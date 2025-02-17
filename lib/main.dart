import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinapp_challenge/app/app.dart';
import 'package:pinapp_challenge/bootstrap.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

void main() {
  bootstrap(
    () => ProviderScope(
      observers: [Logger()],
      child: const App(),
    ),
  );
}
