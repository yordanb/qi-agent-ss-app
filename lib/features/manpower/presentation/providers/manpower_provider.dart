import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/manpower_remote_datasource.dart';
import '../../domain/repository/manpower_repository.dart';
import '../../domain/entities/manpower_coverage.dart';

part 'manpower_provider.g.dart';

@riverpod
ManpowerRemoteDatasource manpowerRemoteDatasource(ref) {
  return ManpowerRemoteDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
ManpowerRepository manpowerRepository(ref) {
  return ManpowerRepository(ref.read(manpowerRemoteDatasourceProvider));
}

@riverpod
Future<List<ManpowerCoverage>> coverageSummary(ref, int year, int month) async {
  final repo = ref.read(manpowerRepositoryProvider);
  return repo.getCoverageSummary(year, month);
}

@riverpod
Future<List<CrewCoverage>> crewCoverage(ref, String? section, int year, int month) async {
  final repo = ref.read(manpowerRepositoryProvider);
  return repo.getCrewCoverage(section, year, month);
}

@riverpod
Future<ManpowerDetail> nrpCoverage(ref, String nrp, int year, int month) async {
  final repo = ref.read(manpowerRepositoryProvider);
  return repo.getNrpCoverage(nrp, year, month);
}
