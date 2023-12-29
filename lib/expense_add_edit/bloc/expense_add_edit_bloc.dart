import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses/expenses.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'expense_add_edit_event.dart';
part 'expense_add_edit_state.dart';

class ExpenseAddEditBloc
    extends Bloc<ExpenseAddEditEvent, ExpenseAddEditState> {
  ExpenseAddEditBloc({
    required ExpensesRepository expenseRepository,
    Expense? initialExpense,
  })  : _expenseRepository = expenseRepository,
        super(
          ExpenseAddEditState(
            initialExpense: initialExpense,
            name: initialExpense?.name ?? '',
            price: initialExpense?.price,
          ),
        ) {
    on<ExpenseNameChanged>(_expenseNameChanged);
    on<ExpensePriceChanged>(_expensePriceChanged);
    on<ExpenseInitialFocusRequested>(_expenseInitialFocusRequested);
    on<ExpenseSubmitted>(_expenseSubmitted);
  }

  @override
  Future<void> close() {
    state.nameFocusNode.dispose();
    state.priceFocusNode.dispose();
    return super.close();
  }

  final ExpensesRepository _expenseRepository;

  FutureOr<void> _expenseNameChanged(
    ExpenseNameChanged event,
    Emitter<ExpenseAddEditState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  FutureOr<void> _expensePriceChanged(
    ExpensePriceChanged event,
    Emitter<ExpenseAddEditState> emit,
  ) {
    emit(
      state.copyWith(
        price: event.price,
      ),
    );
  }

  FutureOr<void> _expenseSubmitted(
    ExpenseSubmitted event,
    Emitter<ExpenseAddEditState> emit,
  ) {
    if (state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      try {
        final expense = (state.initialExpense ?? Expense()).copyWith(
          name: state.name,
          price: state.price,
        );
        _expenseRepository.saveExpense(
          expense,
        );
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
          ),
        );
      } catch (e) {
        log(e.toString());
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
          ),
        );
      }
    }
  }

  FutureOr<void> _expenseInitialFocusRequested(
    ExpenseInitialFocusRequested event,
    Emitter<ExpenseAddEditState> emit,
  ) {
    state.nameFocusNode.requestFocus();
  }
}
