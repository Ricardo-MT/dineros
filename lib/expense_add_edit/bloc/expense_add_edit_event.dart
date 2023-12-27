part of 'expense_add_edit_bloc.dart';

sealed class ExpenseAddEditEvent extends Equatable {
  const ExpenseAddEditEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseNameChanged extends ExpenseAddEditEvent {
  const ExpenseNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class ExpensePriceChanged extends ExpenseAddEditEvent {
  const ExpensePriceChanged(this.price);

  final double price;

  @override
  List<Object> get props => [price];
}

final class ExpenseInitialFocusRequested extends ExpenseAddEditEvent {
  const ExpenseInitialFocusRequested();
}

final class ExpenseSubmitted extends ExpenseAddEditEvent {
  const ExpenseSubmitted();
}
