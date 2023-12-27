import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses/expenses.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:formz/formz.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({
    required ExpensesRepository expenseRepository,
  })  : _expenseRepository = expenseRepository,
        super(const ExpenseState()) {
    on<ExpenseSubscriptionRequested>(_onExpensesRequested);
    on<ExpenseDelete>(_onExpenseDelete);
  }

  final ExpensesRepository _expenseRepository;

  FutureOr<void> _onExpensesRequested(
    ExpenseSubscriptionRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    await emit.forEach(
      _expenseRepository.getExpenses(),
      onData: (expenses) {
        return state.copyWith(
          expenses: expenses
            ..sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
            ),
        );
      },
      onError: (_, __) => state.copyWith(status: FormzSubmissionStatus.failure),
    );
  }

  FutureOr<void> _onExpenseDelete(
    ExpenseDelete event,
    Emitter<ExpenseState> emit,
  ) {
    _expenseRepository.deleteExpense(event.expense);
  }
}
