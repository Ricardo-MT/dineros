import 'package:dineros/counter/counter.dart';
import 'package:dineros/counter/view/android/android_counter_page.dart';
import 'package:dineros/counter/view/ios/ios_counter_page.dart';
import 'package:dineros/widgets/PlatformAwareWidget/platform_aware_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const PlatformAwareWidget(
        androidWidget: AndroidCounterView(),
        iosWidget: IosCounterView(),
      ),
    );
  }
}
