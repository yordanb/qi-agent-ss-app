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

    // Save user session (no JWT — backend uses session-based auth)
    await _storage.saveUser(
      nrp: response.user.nrp,
      nama: response.user.nama,
      isAdmin: response.user.isAdmin,
    );

    return User(
      nrp: response.user.nrp,
      nama: response.user.nama,
      isAdmin: response.user.isAdmin,
    );
  }

  @override
  Future<void> changePassword(String nrp, String oldPassword, String newPassword) async {
    await _datasource.changePassword(nrp, oldPassword, newPassword);
  }

  @override
  Future<void> logout() async {
    await _storage.clearAll();
  }

  @override
  Future<User?> getCurrentUser() async {
    final nrp = await _storage.getUserNrp();
    final nama = await _storage.getUserName();
    final isAdmin = await _storage.getIsAdmin();
    if (nrp == null) return null;
    return User(nrp: nrp, nama: nama ?? '', isAdmin: isAdmin);
  }
}
