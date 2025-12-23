// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$connectivityStatusHash() =>
    r'90eaa0e3dcd34395c28956279426a9a43e53e8d1';

/// See also [connectivityStatus].
@ProviderFor(connectivityStatus)
final connectivityStatusProvider =
    AutoDisposeStreamProvider<List<ConnectivityResult>>.internal(
      connectivityStatus,
      name: r'connectivityStatusProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$connectivityStatusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityStatusRef =
    AutoDisposeStreamProviderRef<List<ConnectivityResult>>;
String _$connectivitySyncHash() => r'e5dd07f9cd28584eae684e891250ed34132577d6';

/// See also [connectivitySync].
@ProviderFor(connectivitySync)
final connectivitySyncProvider = AutoDisposeProvider<void>.internal(
  connectivitySync,
  name: r'connectivitySyncProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivitySyncHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivitySyncRef = AutoDisposeProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
