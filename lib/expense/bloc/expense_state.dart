part of 'expense_bloc.dart';

enum ExpenseViewState { initial, edit }

final class ExpenseState extends Equatable {
  const ExpenseState({
    this.status = FormzSubmissionStatus.initial,
    this.viewState = ExpenseViewState.initial,
    this.expenses = const [],
  });

  final FormzSubmissionStatus status;
  final ExpenseViewState viewState;
  final List<Expense> expenses;

  ExpenseState copyWith({
    FormzSubmissionStatus? status,
    ExpenseViewState? viewState,
    List<Expense>? expenses,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      viewState: viewState ?? this.viewState,
      expenses: expenses ?? this.expenses.toList(),
    );
  }

  @override
  List<Object> get props => [
        status,
        viewState,
        expenses,
      ];
}
