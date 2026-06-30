import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/login_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _datasource;
  final SecureStorageService _storage;

  AuthRepositoryImpl(this._datasource, this._storage);

  @override
  Future<User> login(String nrp, String password) async {
    final response = await _datasource.login(LoginRequest(nrp: nrp, password: password));

    // Save JWT tokens + user data
    await _storage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _storage.saveUser(
      nrp: response.user.nrp,
      nama: response.user.nama,
      role: response.user.role,
    );

    return User(
      nrp: response.user.nrp,
      nama: response.user.nama,
      role: response.user.role,
    );
  }

  @override
  Future<void> changePassword(String nrp, String oldPassword, String newPassword) async {
    await _datasource.changePassword(nrp, oldPassword, newPassword);
  }

  @override
  Future<void> logout() async {
    try {
      await _datasource.logout();
    } catch (_) {}
    await _storage.clearAll();
  }

  @override
  Future<User?> getCurrentUser() async {
    final nrp = await _storage.getUserNrp();
    final nama = await _storage.getUserName();
    final role = await _storage.getUserRole();
    if (nrp == null) return null;
    return User(nrp: nrp, nama: nama ?? '', role: role ?? 'user');
  }
}
