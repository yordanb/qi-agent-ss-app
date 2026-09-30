import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/user_remote_datasource.dart';
import '../../domain/entities/user.dart';

part 'user_provider.g.dart';

@riverpod
UserRemoteDatasource userRemoteDatasource(ref) {
  return UserRemoteDatasource(ref.read(dioClientProvider).dio);
}

// State for user management
class UserManagementState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  const UserManagementState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  UserManagementState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
  }) {
    return UserManagementState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class UserManagementNotifier extends _$UserManagementNotifier {
  @override
  UserManagementState build() {
    return const UserManagementState();
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final datasource = ref.read(userRemoteDatasourceProvider);
      final users = await datasource.getUsers();
      state = UserManagementState(users: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createUser({
    required String nrp,
    required String password,
    String role = 'user',
  }) async {
    try {
      final datasource = ref.read(userRemoteDatasourceProvider);
      await datasource.createUser(nrp: nrp, password: password, role: role);
      await loadUsers();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> updateUser({
    required String nrp,
    String? role,
    bool? isActive,
  }) async {
    try {
      final datasource = ref.read(userRemoteDatasourceProvider);
      await datasource.updateUser(nrp: nrp, role: role, isActive: isActive);
      await loadUsers();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> deleteUser(String nrp) async {
    try {
      final datasource = ref.read(userRemoteDatasourceProvider);
      await datasource.deleteUser(nrp);
      await loadUsers();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<bool> resetPassword({
    required String nrp,
    required String newPassword,
  }) async {
    try {
      final datasource = ref.read(userRemoteDatasourceProvider);
      await datasource.resetPassword(nrp: nrp, newPassword: newPassword);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}
