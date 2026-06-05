// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardRemoteDatasourceHash() =>
    r'3b7e4b0217768ba2c064931dbacaafccc5ebf097';

/// See also [dashboardRemoteDatasource].
@ProviderFor(dashboardRemoteDatasource)
final dashboardRemoteDatasourceProvider =
    AutoDisposeProvider<DashboardRemoteDatasource>.internal(
  dashboardRemoteDatasource,
  name: r'dashboardRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardRemoteDatasourceRef
    = AutoDisposeProviderRef<DashboardRemoteDatasource>;
String _$dashboardRepositoryHash() =>
    r'e2c4024981c28575f111588e95876737883a2a80';

/// See also [dashboardRepository].
@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider =
    AutoDisposeProvider<DashboardRepository>.internal(
  dashboardRepository,
  name: r'dashboardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardRepositoryRef = AutoDisposeProviderRef<DashboardRepository>;
String _$dashboardNotifierHash() => r'7041aa2c463eaffc3e0d8fe8490bcc5cca80b980';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DashboardNotifier
    extends BuildlessAutoDisposeAsyncNotifier<DashboardStats?> {
  late final String nrp;

  FutureOr<DashboardStats?> build(
    String nrp,
  );
}

/// See also [DashboardNotifier].
@ProviderFor(DashboardNotifier)
const dashboardNotifierProvider = DashboardNotifierFamily();

/// See also [DashboardNotifier].
class DashboardNotifierFamily extends Family<AsyncValue<DashboardStats?>> {
  /// See also [DashboardNotifier].
  const DashboardNotifierFamily();

  /// See also [DashboardNotifier].
  DashboardNotifierProvider call(
    String nrp,
  ) {
    return DashboardNotifierProvider(
      nrp,
    );
  }

  @override
  DashboardNotifierProvider getProviderOverride(
    covariant DashboardNotifierProvider provider,
  ) {
    return call(
      provider.nrp,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dashboardNotifierProvider';
}

/// See also [DashboardNotifier].
class DashboardNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DashboardNotifier, DashboardStats?> {
  /// See also [DashboardNotifier].
  DashboardNotifierProvider(
    String nrp,
  ) : this._internal(
          () => DashboardNotifier()..nrp = nrp,
          from: dashboardNotifierProvider,
          name: r'dashboardNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dashboardNotifierHash,
          dependencies: DashboardNotifierFamily._dependencies,
          allTransitiveDependencies:
              DashboardNotifierFamily._allTransitiveDependencies,
          nrp: nrp,
        );

  DashboardNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nrp,
  }) : super.internal();

  final String nrp;

  @override
  FutureOr<DashboardStats?> runNotifierBuild(
    covariant DashboardNotifier notifier,
  ) {
    return notifier.build(
      nrp,
    );
  }

  @override
  Override overrideWith(DashboardNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DashboardNotifierProvider._internal(
        () => create()..nrp = nrp,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nrp: nrp,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DashboardNotifier, DashboardStats?>
      createElement() {
    return _DashboardNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DashboardNotifierProvider && other.nrp == nrp;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nrp.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DashboardNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<DashboardStats?> {
  /// The parameter `nrp` of this provider.
  String get nrp;
}

class _DashboardNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DashboardNotifier,
        DashboardStats?> with DashboardNotifierRef {
  _DashboardNotifierProviderElement(super.provider);

  @override
  String get nrp => (origin as DashboardNotifierProvider).nrp;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
