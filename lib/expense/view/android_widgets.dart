import 'package:dineros/l10n/l10n.dart';
import 'package:expenses/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AndroidNoExpenses extends StatelessWidget {
  const AndroidNoExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.l10n.noExpenses));
  }
}

class AndroidExpenseListItem extends StatelessWidget {
  const AndroidExpenseListItem({
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
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  expense.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat.yMMMd(
                      Localizations.localeOf(context).languageCode,
                    ).format(expense.date),
                  ),
                  const SizedBox.square(
                    dimension: 2,
                  ),
                  Text(
                    priceString,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
