part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseSortChanged extends ExpenseEvent {
  const ExpenseSortChanged(this.sort);

  final ExpenseViewSort sort;

  @override
  List<Object> get props => [sort];
}

final class ExpenseSubscriptionRequested extends ExpenseEvent {}

final class ExpenseDelete extends ExpenseEvent {
  const ExpenseDelete(this.expense);

  final Expense expense;

  @override
  List<Object> get props => [expense];
}
