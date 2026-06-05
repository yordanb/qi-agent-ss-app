// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ss_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ssRemoteDatasourceHash() =>
    r'b43e3c94df9c2ff0bff760e87d0d3966ed2c0623';

/// See also [ssRemoteDatasource].
@ProviderFor(ssRemoteDatasource)
final ssRemoteDatasourceProvider =
    AutoDisposeProvider<SsRemoteDatasource>.internal(
  ssRemoteDatasource,
  name: r'ssRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ssRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SsRemoteDatasourceRef = AutoDisposeProviderRef<SsRemoteDatasource>;
String _$ssRepositoryHash() => r'1345db947c18d683986e867806498dca84ef0810';

/// See also [ssRepository].
@ProviderFor(ssRepository)
final ssRepositoryProvider = AutoDisposeProvider<SsRepository>.internal(
  ssRepository,
  name: r'ssRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ssRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SsRepositoryRef = AutoDisposeProviderRef<SsRepository>;
String _$ssNotifierHash() => r'5744fee42a6d38ae555fa2c702998a27056fad6e';

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

abstract class _$SsNotifier extends BuildlessAutoDisposeAsyncNotifier<SsPage> {
  late final String nrp;

  FutureOr<SsPage> build(
    String nrp,
  );
}

/// See also [SsNotifier].
@ProviderFor(SsNotifier)
const ssNotifierProvider = SsNotifierFamily();

/// See also [SsNotifier].
class SsNotifierFamily extends Family<AsyncValue<SsPage>> {
  /// See also [SsNotifier].
  const SsNotifierFamily();

  /// See also [SsNotifier].
  SsNotifierProvider call(
    String nrp,
  ) {
    return SsNotifierProvider(
      nrp,
    );
  }

  @override
  SsNotifierProvider getProviderOverride(
    covariant SsNotifierProvider provider,
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
  String? get name => r'ssNotifierProvider';
}

/// See also [SsNotifier].
class SsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SsNotifier, SsPage> {
  /// See also [SsNotifier].
  SsNotifierProvider(
    String nrp,
  ) : this._internal(
          () => SsNotifier()..nrp = nrp,
          from: ssNotifierProvider,
          name: r'ssNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ssNotifierHash,
          dependencies: SsNotifierFamily._dependencies,
          allTransitiveDependencies:
              SsNotifierFamily._allTransitiveDependencies,
          nrp: nrp,
        );

  SsNotifierProvider._internal(
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
  FutureOr<SsPage> runNotifierBuild(
    covariant SsNotifier notifier,
  ) {
    return notifier.build(
      nrp,
    );
  }

  @override
  Override overrideWith(SsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SsNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SsNotifier, SsPage> createElement() {
    return _SsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SsNotifierProvider && other.nrp == nrp;
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
mixin SsNotifierRef on AutoDisposeAsyncNotifierProviderRef<SsPage> {
  /// The parameter `nrp` of this provider.
  String get nrp;
}

class _SsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SsNotifier, SsPage>
    with SsNotifierRef {
  _SsNotifierProviderElement(super.provider);

  @override
  String get nrp => (origin as SsNotifierProvider).nrp;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
