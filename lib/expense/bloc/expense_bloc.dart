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
    on<ExpenseSortChanged>(_onExpenseSort);
    on<ExpenseDelete>(_onExpenseDelete);
  }

  final ExpensesRepository _expenseRepository;

  FutureOr<void> _onExpensesRequested(
    ExpenseSubscriptionRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    await emit.forEach(
      _expenseRepository.getExpenses(),
      onData: (expenses) =>
          state.copyWith(expenses: expenses..sort(state.sort.compare)),
      onError: (_, __) => state.copyWith(status: FormzSubmissionStatus.failure),
    );
  }

  FutureOr<void> _onExpenseDelete(
    ExpenseDelete event,
    Emitter<ExpenseState> emit,
  ) {
    _expenseRepository.deleteExpense(event.expense);
  }

  FutureOr<void> _onExpenseSort(
    ExpenseSortChanged event,
    Emitter<ExpenseState> emit,
  ) {
    emit(
      state.copyWith(
        sort: event.sort,
        expenses: state.expenses.toList()..sort(event.sort.compare),
      ),
    );
  }
}
