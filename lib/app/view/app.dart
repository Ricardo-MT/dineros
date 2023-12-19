import 'package:dineros/counter/counter.dart';
import 'package:dineros/l10n/l10n.dart';
import 'package:dineros/widgets/PlatformAwareWidget/platform_aware_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

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
