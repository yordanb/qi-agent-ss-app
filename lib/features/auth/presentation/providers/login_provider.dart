import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import 'auth_provider.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Future<User?> build() async {
    try {
      final repo = ref.read(authRepositoryProvider);
      return repo.getCurrentUser();
    } catch (_) {
      // Storage not available or first run
      return null;
    }
  }

  Future<void> login(String nrp, String password) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.login(nrp, password);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(null);
  }
}
