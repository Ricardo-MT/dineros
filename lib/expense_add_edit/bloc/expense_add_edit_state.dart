part of 'expense_add_edit_bloc.dart';

final class ExpenseAddEditState extends Equatable {
  ExpenseAddEditState({
    this.status = FormzSubmissionStatus.initial,
    this.initialExpense,
    this.name = '',
    FocusNode? nameNode,
    this.price,
    FocusNode? priceNode,
  }) {
    nameFocusNode = nameNode ?? FocusNode();
    priceFocusNode = priceNode ?? FocusNode();
  }

  final FormzSubmissionStatus status;
  final Expense? initialExpense;
  final String name;
  late final FocusNode nameFocusNode;
  final double? price;
  late final FocusNode priceFocusNode;

  bool get isEditing => initialExpense != null;

  bool get isValid => name.isNotEmpty && price != null;

  ExpenseAddEditState copyWith({
    FormzSubmissionStatus? status,
    Expense? initialExpense,
    String? name,
    FocusNode? nameFocusNode,
    double? price,
    FocusNode? priceFocusNode,
  }) {
    return ExpenseAddEditState(
      status: status ?? this.status,
      initialExpense: initialExpense ?? this.initialExpense,
      name: name ?? this.name,
      nameNode: nameFocusNode ?? this.nameFocusNode,
      price: price ?? this.price,
      priceNode: priceFocusNode ?? this.priceFocusNode,
    );
  }

  @override
  List<Object> get props => [
        status,
        initialExpense ?? 'nullInitialExpense',
        name,
        nameFocusNode,
        price ?? 'nullPrice',
        priceFocusNode,
      ];
}
