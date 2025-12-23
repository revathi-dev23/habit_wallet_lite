// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeSettingsHash() => r'39e56244bd10bcad7d97665c286118d335c8b44b';

/// See also [ThemeSettings].
@ProviderFor(ThemeSettings)
final themeSettingsProvider =
    AutoDisposeNotifierProvider<ThemeSettings, ThemeMode>.internal(
      ThemeSettings.new,
      name: r'themeSettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$themeSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeSettings = AutoDisposeNotifier<ThemeMode>;
String _$localeSettingsHash() => r'f27a8050233f47c4381bf3bfca74ccdf4edf0eb3';

/// See also [LocaleSettings].
@ProviderFor(LocaleSettings)
final localeSettingsProvider =
    AutoDisposeNotifierProvider<LocaleSettings, Locale>.internal(
      LocaleSettings.new,
      name: r'localeSettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$localeSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LocaleSettings = AutoDisposeNotifier<Locale>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
