import 'package:flutter/material.dart';

class PlatformAwareWidget extends StatelessWidget {
  const PlatformAwareWidget({
    required this.androidWidget,
    required this.iosWidget,
    super.key,
  });
  final Widget androidWidget;
  final Widget iosWidget;

  @override
  Widget build(BuildContext context) {
    final platf = Theme.of(context).platform;
    if (platf == TargetPlatform.iOS || platf == TargetPlatform.macOS) {
      return iosWidget;
    } else {
      return androidWidget;
    }
  }
}
