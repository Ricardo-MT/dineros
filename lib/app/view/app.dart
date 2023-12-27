import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dineros/expense/view/expense_page.dart';
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
      androidWidget: AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.system,
        builder: (light, dark) {
          return MaterialApp(
            title: 'Dineros',
            theme: light,
            darkTheme: dark,
            home: const ExpensePage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
      iosWidget: CupertinoAdaptiveTheme(
        light: const CupertinoThemeData(
          brightness: Brightness.light,
          barBackgroundColor: CupertinoColors.systemBackground,
          scaffoldBackgroundColor: CupertinoColors.secondarySystemBackground,
        ),
        dark: const CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: CupertinoColors.secondarySystemBackground,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
        ),
        initial: AdaptiveThemeMode.system,
        builder: (theme) {
          return CupertinoApp(
            title: 'Dineros',
            home: const ExpensePage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: theme,
          );
        },
      ),
    );
  }
}
