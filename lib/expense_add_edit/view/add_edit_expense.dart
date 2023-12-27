import 'package:dineros/expense_add_edit/view/android_add_edit_expense.dart';
import 'package:dineros/expense_add_edit/view/ios_add_edit_expense.dart';
import 'package:dineros/widgets/PlatformAwareWidget/platform_aware_widget.dart';
import 'package:flutter/cupertino.dart';

class AddEditExpense extends StatelessWidget {
  const AddEditExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformAwareWidget(
      androidWidget: AndroidAddEditExpenseView(),
      iosWidget: IosAddEditExpenseView(),
    );
  }
}
