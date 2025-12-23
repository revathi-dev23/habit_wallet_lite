import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(_getCurrentLanguageName(context)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLanguageDialog(context, ref),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: Text(_getCurrentTheme(context)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showThemeDialog(context, ref),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Habit Wallet Lite v1.0.0'),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  String _getCurrentLanguageName(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ta' ? 'தமிழ் (Tamil)' : 'English';
  }

  String _getCurrentTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? 'Dark' : 'Light';
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeSettingsProvider);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: currentLocale.languageCode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(localeSettingsProvider.notifier).setLocale(Locale(value));
                  Navigator.pop(dialogContext);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('தமிழ் (Tamil)'),
              value: 'ta',
              groupValue: currentLocale.languageCode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(localeSettingsProvider.notifier).setLocale(Locale(value));
                  Navigator.pop(dialogContext);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeSettingsProvider);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeSettingsProvider.notifier).setTheme(value);
                  Navigator.pop(dialogContext);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeSettingsProvider.notifier).setTheme(value);
                  Navigator.pop(dialogContext);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeSettingsProvider.notifier).setTheme(value);
                  Navigator.pop(dialogContext);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Habit Wallet Lite',
      applicationVersion: '1.0.0',
      applicationLegalese: '\u00A9 2025 Habit Wallet Lite\n\nAn offline-first personal finance manager demo.',
    );
  }
}
