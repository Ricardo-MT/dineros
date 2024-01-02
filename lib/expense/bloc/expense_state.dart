part of 'expense_bloc.dart';

enum ExpenseViewState { initial, edit }

enum ExpenseViewSort {
  dateOldest,
  dateNewest,
  amountLowest,
  amountHighest,
  nameLowest,
  nameHighest
}

extension ExpenseViewSortSorter on ExpenseViewSort {
  int compare(Expense a, Expense b) {
    switch (this) {
      case ExpenseViewSort.dateOldest:
        return a.date.compareTo(b.date);
      case ExpenseViewSort.dateNewest:
        return b.date.compareTo(a.date);
      case ExpenseViewSort.amountLowest:
        return a.price.compareTo(b.price);
      case ExpenseViewSort.amountHighest:
        return b.price.compareTo(a.price);
      case ExpenseViewSort.nameLowest:
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      case ExpenseViewSort.nameHighest:
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
    }
  }
}

final class ExpenseState extends Equatable {
  const ExpenseState({
    this.status = FormzSubmissionStatus.initial,
    this.viewState = ExpenseViewState.initial,
    this.sort = ExpenseViewSort.nameLowest,
    this.expenses = const [],
  });

  final FormzSubmissionStatus status;
  final ExpenseViewState viewState;
  final ExpenseViewSort sort;
  final List<Expense> expenses;

  ExpenseState copyWith({
    FormzSubmissionStatus? status,
    ExpenseViewState? viewState,
    ExpenseViewSort? sort,
    List<Expense>? expenses,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      viewState: viewState ?? this.viewState,
      sort: sort ?? this.sort,
      expenses: expenses ?? this.expenses.toList(),
    );
  }

  @override
  List<Object> get props => [
        status,
        viewState,
        sort,
        expenses,
      ];
}
