import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/auth_interceptor.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../data/datasource/auth_remote_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
SecureStorageService secureStorage(ref) => SecureStorageService();

@riverpod
DioClient dioClient(ref) {
  final client = DioClient(storage: ref.read(secureStorageProvider));
  // Inject Ref ke AuthInterceptor agar bisa trigger forceLogout
  final authInterceptors = client.dio.interceptors
      .whereType<AuthInterceptor>();
  if (authInterceptors.isNotEmpty) {
    authInterceptors.first.setRef(ref);
  }
  return client;
}

@riverpod
AuthRemoteDatasource authRemoteDatasource(ref) {
  return AuthRemoteDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
AuthRepository authRepository(ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDatasourceProvider),
    ref.read(secureStorageProvider),
  );
}
