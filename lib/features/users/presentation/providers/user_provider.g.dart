// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRemoteDatasourceHash() =>
    r'10629077d893d9c8e37969e7a8e167c5bcc8541f';

/// See also [userRemoteDatasource].
@ProviderFor(userRemoteDatasource)
final userRemoteDatasourceProvider =
    AutoDisposeProvider<UserRemoteDatasource>.internal(
  userRemoteDatasource,
  name: r'userRemoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRemoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRemoteDatasourceRef = AutoDisposeProviderRef<UserRemoteDatasource>;
String _$userManagementNotifierHash() =>
    r'72640400dc568ce96aa2b93defe1b9988a1167d2';

/// See also [UserManagementNotifier].
@ProviderFor(UserManagementNotifier)
final userManagementNotifierProvider = AutoDisposeNotifierProvider<
    UserManagementNotifier, UserManagementState>.internal(
  UserManagementNotifier.new,
  name: r'userManagementNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userManagementNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserManagementNotifier = AutoDisposeNotifier<UserManagementState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
