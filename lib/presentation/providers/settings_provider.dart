import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeSettings extends _$ThemeSettings {
  @override
  ThemeMode build() => ThemeMode.system;

  void setTheme(ThemeMode mode) => state = mode;
}

@riverpod
class LocaleSettings extends _$LocaleSettings {
  @override
  Locale build() => const Locale('en');

  void setLocale(Locale locale) => state = locale;
}
