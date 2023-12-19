import 'package:dineros/counter/cubit/counter_cubit.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IosCounterView extends StatelessWidget {
  const IosCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border.fromBorderSide(BorderSide.none),
        backgroundColor: Colors.transparent,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Text('Edit'),
        ),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () => context.read<CounterCubit>().increment(),
      //       child: const Icon(Icons.add),
      //     ),
      //     const SizedBox(height: 8),
      //     FloatingActionButton(
      //       onPressed: () => context.read<CounterCubit>().decrement(),
      //       child: const Icon(Icons.remove),
      //     ),
      //   ],
      // ),
      child: Column(
        children: [
          const Expanded(
            child: Center(child: CounterText()),
          ),
          DecoratedBox(
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
                      child: const Icon(CupertinoIcons.add),
                    ),
                  ),
                  const Expanded(child: Center(child: Text('Counter'))),
                  CupertinoButton(
                    onPressed: () => context.read<CounterCubit>().decrement(),
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
