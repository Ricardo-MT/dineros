import 'package:dineros/expense/bloc/expense_bloc.dart';
import 'package:dineros/expense/view/ios_widgets.dart';
import 'package:dineros/expense_add_edit/view/add_edit_expense.dart';
import 'package:dineros/expense_add_edit/view/ios_add_edit_expense.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IosExpenseView extends StatelessWidget {
  const IosExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border.fromBorderSide(BorderSide.none),
        backgroundColor: Colors.transparent,
        middle: Text(l10n.expensesPageTitle),
        trailing: const IosFilterDropdownButton(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state.expenses.isEmpty) {
                    return const _NoExpenses();
                  }

                  return ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = state.expenses[index];
                      return GestureDetector(
                        onLongPress: () {
                          HapticFeedback.heavyImpact();
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (_) => SafeArea(
                              child: CupertinoActionSheet(
                                title: Text(expense.name),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showAdaptiveDialog<void>(
                                        context: context,
                                        builder: (_) => IosAddEditExpenseView(
                                          initialExpense: expense,
                                        ),
                                      );
                                    },
                                    child: Text(l10n.edit),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () async {
                                      final expenseBloc =
                                          context.read<ExpenseBloc>();
                                      Navigator.of(context).pop();
                                      final res =
                                          await showCupertinoDialog<bool?>(
                                        context: context,
                                        builder: (_) => CupertinoAlertDialog(
                                          title: Text(
                                            '${l10n.deletingExpenseTitle} ${expense.name}',
                                          ),
                                          content: Text(
                                            l10n.deletingExpenseDescription,
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: Text(l10n.cancel),
                                            ),
                                            CupertinoDialogAction(
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text(l10n.delete),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (res == true) {
                                        expenseBloc.add(ExpenseDelete(expense));
                                      }
                                    },
                                    child: Text(
                                      l10n.delete,
                                      style: const TextStyle(
                                        color: CupertinoColors.destructiveRed,
                                      ),
                                    ),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(l10n.cancel),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: expense.id,
                          child: ExpenseListItem(expense: expense),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _NoExpenses extends StatelessWidget {
  const _NoExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.l10n.noExpenses));
  }
}

class _Footer extends StatelessWidget {
  const _Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility.maintain(
              visible: false,
              child: CupertinoButton(
                onPressed: () {},
                child: const Icon(CupertinoIcons.create_solid),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
                  buildWhen: (previous, current) =>
                      previous.expenses != current.expenses,
                  builder: (context, state) {
                    final totalAmount = state.expenses.fold<double>(
                      0,
                      (previousValue, element) => previousValue + element.price,
                    );
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.total,
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                            locale:
                                Localizations.localeOf(context).languageCode,
                          ).format(
                            totalAmount == totalAmount.toInt()
                                ? totalAmount.toInt()
                                : totalAmount,
                          ),
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .tabLabelTextStyle
                              .copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () => showAdaptiveDialog<void>(
                context: context,
                builder: (_) => const AddEditExpense(),
              ),
              child: const Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
    );
  }
}
