import 'package:expenses/expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
