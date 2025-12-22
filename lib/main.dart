import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'core/notifications/notification_service.dart';

void main() async {
  // ignore: unawaited_futures
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    final notificationService = NotificationService();
    await notificationService.init();
    try {
      // Fire and forget - don't await notification scheduling
      // ignore: unawaited_futures
      notificationService.scheduleDailyReminder();
    } catch (e) {
      debugPrint("Failed to schedule reminder: $e");
    }

    // Verify deep link intent handling via router later

    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    if (kDebugMode) {
      debugPrint("Global Error Caught: $error");
      print(stack);
    }
    // In production, log to Crashlytics or Sentry
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habit Wallet Lite',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ta'), // Tamil
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
