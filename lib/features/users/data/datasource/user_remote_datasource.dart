import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';

class UserRemoteDatasource {
  final Dio _dio;

  UserRemoteDatasource(this._dio);

  Future<List<User>> getUsers() async {
    final response = await _dio.get('/auth/admin/users');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<User> createUser({
    required String nrp,
    required String password,
    String role = 'user',
  }) async {
    final response = await _dio.post(
      '/auth/admin/users',
      data: {
        'nrp': nrp,
        'password': password,
        'role': role,
      },
    );
    return User.fromJson(response.data as Map<String, dynamic>);
  }

  Future<User> updateUser({
    required String nrp,
    String? role,
    bool? isActive,
  }) async {
    final response = await _dio.patch(
      '/auth/admin/users/$nrp',
      data: {
        if (role != null) 'role': role,
        if (isActive != null) 'is_active': isActive,
      },
    );
    return User.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteUser(String nrp) async {
    await _dio.delete('/auth/admin/users/$nrp');
  }

  Future<void> resetPassword({
    required String nrp,
    required String newPassword,
  }) async {
    await _dio.post(
      '/auth/admin/reset-password',
      data: {
        'nrp': nrp,
        'new_password': newPassword,
      },
    );
  }
}
