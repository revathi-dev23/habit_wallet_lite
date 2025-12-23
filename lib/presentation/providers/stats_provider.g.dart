// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$monthlySpendingHash() => r'd1a4ea10436684aa542d04437bf0c2c6c9c492fa';

/// See also [monthlySpending].
@ProviderFor(monthlySpending)
final monthlySpendingProvider =
    AutoDisposeFutureProvider<MonthlyStats>.internal(
      monthlySpending,
      name: r'monthlySpendingProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$monthlySpendingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MonthlySpendingRef = AutoDisposeFutureProviderRef<MonthlyStats>;
String _$selectedMonthHash() => r'edab7a555d14b0a3f05c46c1b8c21f3d55567e85';

/// See also [SelectedMonth].
@ProviderFor(SelectedMonth)
final selectedMonthProvider =
    AutoDisposeNotifierProvider<SelectedMonth, DateTime?>.internal(
      SelectedMonth.new,
      name: r'selectedMonthProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedMonth = AutoDisposeNotifier<DateTime?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
