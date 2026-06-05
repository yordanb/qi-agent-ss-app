import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String nrp, String password);
  Future<void> changePassword(String nrp, String oldPassword, String newPassword);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
