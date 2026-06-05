// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manpower_cud_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$manpowerCudDatasourceHash() =>
    r'059d4a378bc3d80049d2a8875b135bcdca778808';

/// See also [manpowerCudDatasource].
@ProviderFor(manpowerCudDatasource)
final manpowerCudDatasourceProvider =
    AutoDisposeProvider<ManpowerCudDatasource>.internal(
  manpowerCudDatasource,
  name: r'manpowerCudDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$manpowerCudDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ManpowerCudDatasourceRef
    = AutoDisposeProviderRef<ManpowerCudDatasource>;
String _$manpowerSectionsHash() => r'4e1974132fc20a5f1148391f0e1a43be25a0be10';

/// See also [manpowerSections].
@ProviderFor(manpowerSections)
final manpowerSectionsProvider =
    AutoDisposeFutureProvider<List<String>>.internal(
  manpowerSections,
  name: r'manpowerSectionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$manpowerSectionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ManpowerSectionsRef = AutoDisposeFutureProviderRef<List<String>>;
String _$manpowerCrewsHash() => r'3e5416c06cb08c5825adc7aed5591aef31ca688c';

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

/// See also [manpowerCrews].
@ProviderFor(manpowerCrews)
const manpowerCrewsProvider = ManpowerCrewsFamily();

/// See also [manpowerCrews].
class ManpowerCrewsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [manpowerCrews].
  const ManpowerCrewsFamily();

  /// See also [manpowerCrews].
  ManpowerCrewsProvider call(
    String? section,
  ) {
    return ManpowerCrewsProvider(
      section,
    );
  }

  @override
  ManpowerCrewsProvider getProviderOverride(
    covariant ManpowerCrewsProvider provider,
  ) {
    return call(
      provider.section,
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
  String? get name => r'manpowerCrewsProvider';
}

/// See also [manpowerCrews].
class ManpowerCrewsProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [manpowerCrews].
  ManpowerCrewsProvider(
    String? section,
  ) : this._internal(
          (ref) => manpowerCrews(
            ref as ManpowerCrewsRef,
            section,
          ),
          from: manpowerCrewsProvider,
          name: r'manpowerCrewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$manpowerCrewsHash,
          dependencies: ManpowerCrewsFamily._dependencies,
          allTransitiveDependencies:
              ManpowerCrewsFamily._allTransitiveDependencies,
          section: section,
        );

  ManpowerCrewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.section,
  }) : super.internal();

  final String? section;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(ManpowerCrewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ManpowerCrewsProvider._internal(
        (ref) => create(ref as ManpowerCrewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        section: section,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ManpowerCrewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ManpowerCrewsProvider && other.section == section;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, section.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ManpowerCrewsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `section` of this provider.
  String? get section;
}

class _ManpowerCrewsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ManpowerCrewsRef {
  _ManpowerCrewsProviderElement(super.provider);

  @override
  String? get section => (origin as ManpowerCrewsProvider).section;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
