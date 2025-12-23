import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/router/app_router.dart';
import 'presentation/theme/app_theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'core/notifications/notification_service.dart';

import 'presentation/providers/settings_provider.dart';

void main() async {
    unawaited(runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      
      final notificationService = NotificationService();
      await notificationService.init(); // Must wait for init (timezone etc)
      try {
        await notificationService.scheduleDailyReminder();
      } catch (e) {
        debugPrint("Failed to schedule reminder: $e");
      }

      runApp(const ProviderScope(child: MyApp()));
    }, (error, stack) {
      if (kDebugMode) {
        debugPrint("Global Error Caught: $error");
      }
    }));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeSettingsProvider);
    final locale = ref.watch(localeSettingsProvider);

    return MaterialApp.router(
      title: 'Habit Wallet Lite',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ta'),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
