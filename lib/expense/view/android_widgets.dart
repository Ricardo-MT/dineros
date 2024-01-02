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
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                expense.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMd(
                      Localizations.localeOf(context).languageCode,
                    ).format(expense.date),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(0.5),
                        ),
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
