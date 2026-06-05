import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/dashboard_remote_datasource.dart';
import '../../data/repository/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repository/dashboard_repository.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardRemoteDatasource dashboardRemoteDatasource(ref) {
  return DashboardRemoteDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
DashboardRepository dashboardRepository(ref) {
  return DashboardRepositoryImpl(ref.read(dashboardRemoteDatasourceProvider));
}

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardStats?> build(String nrp) async {
    final repo = ref.read(dashboardRepositoryProvider);
    return repo.getStats(nrp);
  }

  Future<void> refresh(String nrp) async {
    state = const AsyncLoading();
    final repo = ref.read(dashboardRepositoryProvider);
    try {
      final stats = await repo.getStats(nrp);
      state = AsyncData(stats);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
