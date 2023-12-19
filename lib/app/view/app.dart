import 'package:dineros/counter/counter.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:dineros/widgets/PlatformAwareWidget/platform_aware_widget.dart';
import 'package:expenses_repository/expenses_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    required this.expensesRepository,
    super.key,
  });

  final ExpensesRepository expensesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ExpensesRepository>(
          create: (_) => expensesRepository,
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformAwareWidget(
      androidWidget: MaterialApp(
        title: 'Dineros',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const CounterPage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
      iosWidget: const CupertinoApp(
        title: 'Dineros',
        home: CounterPage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
