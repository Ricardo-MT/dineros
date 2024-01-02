import 'package:dineros/expense/bloc/expense_bloc.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:expenses/expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_down_button/pull_down_button.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({
    required this.expense,
    super.key,
  });
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final isInteger = expense.price == expense.price.toInt();
    final priceString = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).languageCode,
      decimalDigits: isInteger ? 0 : null,
    ).format(
      isInteger ? expense.price.toInt() : expense.price,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor.withOpacity(1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                expense.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CupertinoTheme.of(context)
                    .textTheme
                    .dateTimePickerTextStyle,
              ),
              const SizedBox(width: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMd(
                      Localizations.localeOf(context).languageCode,
                    ).format(expense.date),
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .tabLabelTextStyle
                        .copyWith(
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox.square(
                    dimension: 2,
                  ),
                  Text(
                    priceString,
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IosFilterDropdownButton extends StatelessWidget {
  const IosFilterDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      buildWhen: (previous, current) => previous.sort != current.sort,
      builder: (context, state) {
        return PullDownButton(
          buttonBuilder: (context, showMenu) => CupertinoButton(
            onPressed: showMenu,
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.arrow_up_arrow_down_circle),
          ),
          itemBuilder: (BuildContext context) => buildMenuItems(context)
              .map(
                (item) => PullDownMenuItem(
                  onTap: () => context.read<ExpenseBloc>().add(
                        ExpenseSortChanged(item.value),
                      ),
                  title: item.title,
                  icon: state.sort == item.value
                      ? (CupertinoIcons.checkmark_alt)
                      : null,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

List<MenuItem> buildMenuItems(BuildContext context) {
  final l10n = context.l10n;
  return [
    MenuItem(
      title: l10n.nameLowest,
      value: ExpenseViewSort.nameLowest,
    ),
    MenuItem(
      title: l10n.nameHighest,
      value: ExpenseViewSort.nameHighest,
    ),
    MenuItem(
      title: l10n.amountLowest,
      value: ExpenseViewSort.amountLowest,
    ),
    MenuItem(
      title: l10n.amountHighest,
      value: ExpenseViewSort.amountHighest,
    ),
    MenuItem(
      title: l10n.dateOldest,
      value: ExpenseViewSort.dateOldest,
    ),
    MenuItem(
      title: l10n.dateNewest,
      value: ExpenseViewSort.dateNewest,
    ),
  ];
}

class MenuItem {
  const MenuItem({
    required this.title,
    required this.value,
  });
  final String title;
  final ExpenseViewSort value;
}
