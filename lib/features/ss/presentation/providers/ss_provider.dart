import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/ss_remote_datasource.dart';
import '../../data/repository/ss_repository_impl.dart';
import '../../domain/entities/ss.dart';
import '../../domain/repository/ss_repository.dart';

part 'ss_provider.g.dart';

@riverpod
SsRemoteDatasource ssRemoteDatasource(ref) {
  return SsRemoteDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
SsRepository ssRepository(ref) {
  return SsRepositoryImpl(ref.read(ssRemoteDatasourceProvider));
}

@riverpod
class SsNotifier extends _$SsNotifier {
  @override
  Future<SsPage> build(String nrp) async {
    final repo = ref.read(ssRepositoryProvider);
    return repo.getSsByNrp(nrp, 1);
  }

  Future<void> refresh(String nrp) async {
    state = const AsyncLoading();
    final repo = ref.read(ssRepositoryProvider);
    try {
      final page = await repo.getSsByNrp(nrp, 1);
      state = AsyncData(page);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
