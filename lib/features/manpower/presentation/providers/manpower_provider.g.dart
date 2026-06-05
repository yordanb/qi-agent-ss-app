// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manpower_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$manpowerRemoteDatasourceHash() =>
    r'd9e0f111fc8bf9dc4f4efefb835fdba73c03dd70';

/// See also [manpowerRemoteDatasource].
@ProviderFor(manpowerRemoteDatasource)
final manpowerRemoteDatasourceProvider =
    AutoDisposeProvider<ManpowerRemoteDatasource>.internal(
  manpowerRemoteDatasource,
  name: r'manpowerRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$manpowerRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ManpowerRemoteDatasourceRef
    = AutoDisposeProviderRef<ManpowerRemoteDatasource>;
String _$manpowerRepositoryHash() =>
    r'edbeecf1b5a3ec0d8229e9d620110faa75400aca';

/// See also [manpowerRepository].
@ProviderFor(manpowerRepository)
final manpowerRepositoryProvider =
    AutoDisposeProvider<ManpowerRepository>.internal(
  manpowerRepository,
  name: r'manpowerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$manpowerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ManpowerRepositoryRef = AutoDisposeProviderRef<ManpowerRepository>;
String _$coverageSummaryHash() => r'10bd8b88720ad9e9bf3979348781f60641db94f0';

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

/// See also [coverageSummary].
@ProviderFor(coverageSummary)
const coverageSummaryProvider = CoverageSummaryFamily();

/// See also [coverageSummary].
class CoverageSummaryFamily extends Family<AsyncValue<List<ManpowerCoverage>>> {
  /// See also [coverageSummary].
  const CoverageSummaryFamily();

  /// See also [coverageSummary].
  CoverageSummaryProvider call(
    int year,
    int month,
  ) {
    return CoverageSummaryProvider(
      year,
      month,
    );
  }

  @override
  CoverageSummaryProvider getProviderOverride(
    covariant CoverageSummaryProvider provider,
  ) {
    return call(
      provider.year,
      provider.month,
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
  String? get name => r'coverageSummaryProvider';
}

/// See also [coverageSummary].
class CoverageSummaryProvider
    extends AutoDisposeFutureProvider<List<ManpowerCoverage>> {
  /// See also [coverageSummary].
  CoverageSummaryProvider(
    int year,
    int month,
  ) : this._internal(
          (ref) => coverageSummary(
            ref as CoverageSummaryRef,
            year,
            month,
          ),
          from: coverageSummaryProvider,
          name: r'coverageSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coverageSummaryHash,
          dependencies: CoverageSummaryFamily._dependencies,
          allTransitiveDependencies:
              CoverageSummaryFamily._allTransitiveDependencies,
          year: year,
          month: month,
        );

  CoverageSummaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.year,
    required this.month,
  }) : super.internal();

  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<ManpowerCoverage>> Function(CoverageSummaryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CoverageSummaryProvider._internal(
        (ref) => create(ref as CoverageSummaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ManpowerCoverage>> createElement() {
    return _CoverageSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoverageSummaryProvider &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoverageSummaryRef
    on AutoDisposeFutureProviderRef<List<ManpowerCoverage>> {
  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _CoverageSummaryProviderElement
    extends AutoDisposeFutureProviderElement<List<ManpowerCoverage>>
    with CoverageSummaryRef {
  _CoverageSummaryProviderElement(super.provider);

  @override
  int get year => (origin as CoverageSummaryProvider).year;
  @override
  int get month => (origin as CoverageSummaryProvider).month;
}

String _$crewCoverageHash() => r'bf81f8b5f2246340419bef9b609e9b2a1efcd82d';

/// See also [crewCoverage].
@ProviderFor(crewCoverage)
const crewCoverageProvider = CrewCoverageFamily();

/// See also [crewCoverage].
class CrewCoverageFamily extends Family<AsyncValue<List<CrewCoverage>>> {
  /// See also [crewCoverage].
  const CrewCoverageFamily();

  /// See also [crewCoverage].
  CrewCoverageProvider call(
    String? section,
    int year,
    int month,
  ) {
    return CrewCoverageProvider(
      section,
      year,
      month,
    );
  }

  @override
  CrewCoverageProvider getProviderOverride(
    covariant CrewCoverageProvider provider,
  ) {
    return call(
      provider.section,
      provider.year,
      provider.month,
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
  String? get name => r'crewCoverageProvider';
}

/// See also [crewCoverage].
class CrewCoverageProvider
    extends AutoDisposeFutureProvider<List<CrewCoverage>> {
  /// See also [crewCoverage].
  CrewCoverageProvider(
    String? section,
    int year,
    int month,
  ) : this._internal(
          (ref) => crewCoverage(
            ref as CrewCoverageRef,
            section,
            year,
            month,
          ),
          from: crewCoverageProvider,
          name: r'crewCoverageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$crewCoverageHash,
          dependencies: CrewCoverageFamily._dependencies,
          allTransitiveDependencies:
              CrewCoverageFamily._allTransitiveDependencies,
          section: section,
          year: year,
          month: month,
        );

  CrewCoverageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.section,
    required this.year,
    required this.month,
  }) : super.internal();

  final String? section;
  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<List<CrewCoverage>> Function(CrewCoverageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CrewCoverageProvider._internal(
        (ref) => create(ref as CrewCoverageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        section: section,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CrewCoverage>> createElement() {
    return _CrewCoverageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CrewCoverageProvider &&
        other.section == section &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, section.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CrewCoverageRef on AutoDisposeFutureProviderRef<List<CrewCoverage>> {
  /// The parameter `section` of this provider.
  String? get section;

  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _CrewCoverageProviderElement
    extends AutoDisposeFutureProviderElement<List<CrewCoverage>>
    with CrewCoverageRef {
  _CrewCoverageProviderElement(super.provider);

  @override
  String? get section => (origin as CrewCoverageProvider).section;
  @override
  int get year => (origin as CrewCoverageProvider).year;
  @override
  int get month => (origin as CrewCoverageProvider).month;
}

String _$nrpCoverageHash() => r'6d3e21abc149c698672d700e3f2ed741d8dc886e';

/// See also [nrpCoverage].
@ProviderFor(nrpCoverage)
const nrpCoverageProvider = NrpCoverageFamily();

/// See also [nrpCoverage].
class NrpCoverageFamily extends Family<AsyncValue<ManpowerDetail>> {
  /// See also [nrpCoverage].
  const NrpCoverageFamily();

  /// See also [nrpCoverage].
  NrpCoverageProvider call(
    String nrp,
    int year,
    int month,
  ) {
    return NrpCoverageProvider(
      nrp,
      year,
      month,
    );
  }

  @override
  NrpCoverageProvider getProviderOverride(
    covariant NrpCoverageProvider provider,
  ) {
    return call(
      provider.nrp,
      provider.year,
      provider.month,
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
  String? get name => r'nrpCoverageProvider';
}

/// See also [nrpCoverage].
class NrpCoverageProvider extends AutoDisposeFutureProvider<ManpowerDetail> {
  /// See also [nrpCoverage].
  NrpCoverageProvider(
    String nrp,
    int year,
    int month,
  ) : this._internal(
          (ref) => nrpCoverage(
            ref as NrpCoverageRef,
            nrp,
            year,
            month,
          ),
          from: nrpCoverageProvider,
          name: r'nrpCoverageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$nrpCoverageHash,
          dependencies: NrpCoverageFamily._dependencies,
          allTransitiveDependencies:
              NrpCoverageFamily._allTransitiveDependencies,
          nrp: nrp,
          year: year,
          month: month,
        );

  NrpCoverageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nrp,
    required this.year,
    required this.month,
  }) : super.internal();

  final String nrp;
  final int year;
  final int month;

  @override
  Override overrideWith(
    FutureOr<ManpowerDetail> Function(NrpCoverageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NrpCoverageProvider._internal(
        (ref) => create(ref as NrpCoverageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nrp: nrp,
        year: year,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ManpowerDetail> createElement() {
    return _NrpCoverageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NrpCoverageProvider &&
        other.nrp == nrp &&
        other.year == year &&
        other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nrp.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NrpCoverageRef on AutoDisposeFutureProviderRef<ManpowerDetail> {
  /// The parameter `nrp` of this provider.
  String get nrp;

  /// The parameter `year` of this provider.
  int get year;

  /// The parameter `month` of this provider.
  int get month;
}

class _NrpCoverageProviderElement
    extends AutoDisposeFutureProviderElement<ManpowerDetail>
    with NrpCoverageRef {
  _NrpCoverageProviderElement(super.provider);

  @override
  String get nrp => (origin as NrpCoverageProvider).nrp;
  @override
  int get year => (origin as NrpCoverageProvider).year;
  @override
  int get month => (origin as NrpCoverageProvider).month;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
