import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );
      final data = response.data as Map<String, dynamic>;
      final userData = data['user'] as Map<String, dynamic>? ?? {};
      return LoginResponse(
        accessToken: data['access_token'] ?? '',
        refreshToken: data['refresh_token'] ?? '',
        user: UserModel(
          nrp: userData['nrp'] ?? request.nrp,
          nama: userData['nama'] ?? '',
          role: userData['role'] ?? 'user',
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> changePassword(String nrp, String oldPassword, String newPassword) async {
    try {
      await _dio.post(
        ApiConstants.changePassword,
        data: {
          'nrp': nrp,
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } on DioException {
      // Best-effort: ignore errors on logout
    }
  }

  NetworkException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException.timeout();
    }
    if (e.type == DioExceptionType.connectionError) {
      return NetworkException.noConnection();
    }
    final code = e.response?.statusCode;
    final responseData = e.response?.data;
    String message;
    if (responseData is Map<String, dynamic> && responseData['detail'] != null) {
      message = responseData['detail'].toString();
    } else if (responseData is String) {
      message = responseData;
    } else {
      message = e.message ?? '';
    }
    if (code != null) {
      return NetworkException(message: message, statusCode: code, data: responseData);
    }
    return NetworkException(message: message);
  }
}
