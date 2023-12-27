import 'package:dineros/expense_add_edit/bloc/expense_add_edit_bloc.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:expenses/expenses.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class IosAddEditExpenseView extends StatelessWidget {
  const IosAddEditExpenseView({
    this.initialExpense,
    super.key,
  });

  final Expense? initialExpense;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseAddEditBloc(
        initialExpense: initialExpense,
        expenseRepository: context.read<ExpensesRepository>(),
      )..add(const ExpenseInitialFocusRequested()),
      child: const _AddEditView(),
    );
  }
}

class _AddEditView extends StatelessWidget {
  const _AddEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseAddEditBloc, ExpenseAddEditState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: const AlertDialog.adaptive(
        title: _ModalTitle(),
        content: _ModalContent(),
        actions: [
          _ModalCancelButton(),
          _ModalSaveButton(),
        ],
      ),
    );
  }
}

// Widget stating whether the expense is being added or edited
class _ModalTitle extends StatelessWidget {
  const _ModalTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseAddEditBloc, ExpenseAddEditState>(
      buildWhen: (previous, current) =>
          previous.initialExpense != current.initialExpense,
      builder: (context, state) {
        final l10n = context.l10n;
        final text =
            state.isEditing ? l10n.editExpenseTitle : l10n.addExpenseTitle;
        return Text(text);
      },
    );
  }
}

// Widget containing text fields for 'name' and 'price'
class _ModalContent extends StatelessWidget {
  const _ModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox.square(
          dimension: 18,
        ),
        _NameInput(),
        SizedBox.square(
          dimension: 14,
        ),
        _PriceInput(),
      ],
    );
  }
}

// Widget containing the text input for the 'name' field
class _NameInput extends StatelessWidget {
  const _NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseAddEditBloc, ExpenseAddEditState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CupertinoTextFormFieldRow(
          focusNode: state.nameFocusNode,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          initialValue: state.name,
          key: const Key('expenseForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<ExpenseAddEditBloc>().add(ExpenseNameChanged(name)),
          placeholder: context.l10n.nameFormFieldLabel,
          onEditingComplete: () {
            state.priceFocusNode.requestFocus();
          },
        );
      },
    );
  }
}

// Widget containing the text input for the 'price' field
class _PriceInput extends StatelessWidget {
  const _PriceInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseAddEditBloc, ExpenseAddEditState>(
      buildWhen: (previous, current) => previous.price != current.price,
      builder: (context, state) {
        // Format the price to a string with 0 decimal places if its value is
        // equal to an integer.
        final initialValue = state.price?.truncate() == state.price
            ? state.price?.truncate().toString()
            : state.price.toString();
        return CupertinoTextFormFieldRow(
          focusNode: state.priceFocusNode,
          key: const Key('expenseForm_priceInput_textField'),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          initialValue: initialValue,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          onChanged: (price) => context
              .read<ExpenseAddEditBloc>()
              .add(ExpensePriceChanged(double.tryParse(price) ?? 0.0)),
          placeholder: context.l10n.priceFormFieldLabel,
          onEditingComplete: () {
            state.priceFocusNode.unfocus();
            context.read<ExpenseAddEditBloc>().add(const ExpenseSubmitted());
          },
        );
      },
    );
  }
}

// Widget for the cancel button
class _ModalCancelButton extends StatelessWidget {
  const _ModalCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(context.l10n.cancel),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

// Widget for the save button
class _ModalSaveButton extends StatelessWidget {
  const _ModalSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(context.l10n.save),
      onPressed: () {
        context.read<ExpenseAddEditBloc>().add(const ExpenseSubmitted());
      },
    );
  }
}
