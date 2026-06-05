// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'esic_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$esicRemoteDatasourceHash() =>
    r'f76aa824e8b8fcabe2c0b93b66b99c5f87507d40';

/// See also [esicRemoteDatasource].
@ProviderFor(esicRemoteDatasource)
final esicRemoteDatasourceProvider =
    AutoDisposeProvider<EsicRemoteDatasource>.internal(
  esicRemoteDatasource,
  name: r'esicRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$esicRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EsicRemoteDatasourceRef = AutoDisposeProviderRef<EsicRemoteDatasource>;
String _$esicRepositoryHash() => r'8a7a8f6b9ae8c25e50ecf2e9322d1852bd62e288';

/// See also [esicRepository].
@ProviderFor(esicRepository)
final esicRepositoryProvider = AutoDisposeProvider<EsicRepository>.internal(
  esicRepository,
  name: r'esicRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$esicRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EsicRepositoryRef = AutoDisposeProviderRef<EsicRepository>;
String _$esicNotifierHash() => r'817e91f39b3822d9cc16388b0bde9f5eef029c23';

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

abstract class _$EsicNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Snapshot>> {
  late final String nrp;

  FutureOr<List<Snapshot>> build(
    String nrp,
  );
}

/// See also [EsicNotifier].
@ProviderFor(EsicNotifier)
const esicNotifierProvider = EsicNotifierFamily();

/// See also [EsicNotifier].
class EsicNotifierFamily extends Family<AsyncValue<List<Snapshot>>> {
  /// See also [EsicNotifier].
  const EsicNotifierFamily();

  /// See also [EsicNotifier].
  EsicNotifierProvider call(
    String nrp,
  ) {
    return EsicNotifierProvider(
      nrp,
    );
  }

  @override
  EsicNotifierProvider getProviderOverride(
    covariant EsicNotifierProvider provider,
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
  String? get name => r'esicNotifierProvider';
}

/// See also [EsicNotifier].
class EsicNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EsicNotifier, List<Snapshot>> {
  /// See also [EsicNotifier].
  EsicNotifierProvider(
    String nrp,
  ) : this._internal(
          () => EsicNotifier()..nrp = nrp,
          from: esicNotifierProvider,
          name: r'esicNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$esicNotifierHash,
          dependencies: EsicNotifierFamily._dependencies,
          allTransitiveDependencies:
              EsicNotifierFamily._allTransitiveDependencies,
          nrp: nrp,
        );

  EsicNotifierProvider._internal(
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
  FutureOr<List<Snapshot>> runNotifierBuild(
    covariant EsicNotifier notifier,
  ) {
    return notifier.build(
      nrp,
    );
  }

  @override
  Override overrideWith(EsicNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EsicNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<EsicNotifier, List<Snapshot>>
      createElement() {
    return _EsicNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EsicNotifierProvider && other.nrp == nrp;
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
mixin EsicNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Snapshot>> {
  /// The parameter `nrp` of this provider.
  String get nrp;
}

class _EsicNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EsicNotifier,
        List<Snapshot>> with EsicNotifierRef {
  _EsicNotifierProviderElement(super.provider);

  @override
  String get nrp => (origin as EsicNotifierProvider).nrp;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
