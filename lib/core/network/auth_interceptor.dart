import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/secure_storage_service.dart';
import '../../features/auth/presentation/providers/login_provider.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;
  Ref? _ref;

  AuthInterceptor(this._storage);

  /// Dipanggil sekali dari DioClient setelah ProviderScope tersedia
  void setRef(Ref ref) {
    _ref = ref;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip token untuk login
    if (options.path.contains('/auth/login')) {
      return handler.next(options);
    }

    final token = await _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired — clear storage + trigger Riverpod logout
      await _storage.clearAll();
      _ref?.read(loginNotifierProvider.notifier).forceLogout();
      return handler.next(err);
    }
    return handler.next(err);
  }
}
