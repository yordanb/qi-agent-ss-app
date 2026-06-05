import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/esic_remote_datasource.dart';
import '../../data/repository/esic_repository_impl.dart';
import '../../domain/entities/snapshot.dart';
import '../../domain/repository/esic_repository.dart';

part 'esic_provider.g.dart';

@riverpod
EsicRemoteDatasource esicRemoteDatasource(ref) {
  return EsicRemoteDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
EsicRepository esicRepository(ref) {
  return EsicRepositoryImpl(ref.read(esicRemoteDatasourceProvider));
}

@riverpod
class EsicNotifier extends _$EsicNotifier {
  @override
  Future<List<Snapshot>> build(String nrp) async {
    final repo = ref.read(esicRepositoryProvider);
    return repo.getSnapshots(nrp);
  }

  Future<void> refresh(String nrp) async {
    state = const AsyncLoading();
    final repo = ref.read(esicRepositoryProvider);
    try {
      final data = await repo.getSnapshots(nrp);
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
