import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/manpower_cud_datasource.dart';
import '../../data/models/manpower_item.dart';

part 'manpower_cud_provider.g.dart';

@riverpod
ManpowerCudDatasource manpowerCudDatasource(ref) {
  return ManpowerCudDatasource(ref.read(dioClientProvider).dio);
}

@riverpod
Future<List<String>> manpowerSections(ref) async {
  final ds = ref.read(manpowerCudDatasourceProvider);
  final items = await ds.getAll(pageSize: 500);
  final sections = items.map((e) => e.section).where((s) => s.isNotEmpty).toSet().toList()..sort();
  return sections;
}

@riverpod
Future<List<String>> manpowerCrews(ref, String? section) async {
  final ds = ref.read(manpowerCudDatasourceProvider);
  final items = await ds.getAll(section: section, pageSize: 500);
  final crews = items.map((e) => e.crew).where((c) => c.isNotEmpty).toSet().toList()..sort();
  return crews;
}
