import '../../domain/entities/snapshot.dart';
import '../../domain/repository/esic_repository.dart';
import '../datasource/esic_remote_datasource.dart';

class EsicRepositoryImpl implements EsicRepository {
  final EsicRemoteDatasource _datasource;

  EsicRepositoryImpl(this._datasource);

  @override
  Future<List<Snapshot>> getSnapshots(String nrp) async {
    final models = await _datasource.getSnapshots(nrp);
    return models.map((m) => Snapshot(
      id: m.id,
      nrp: m.nrp,
      nama: m.nama,
      dept: m.dept,
      snapshotDate: m.snapshotDate,
      dokumenDiakses: m.dokumenDiakses,
      dokumenMtd: m.dokumenMtd,
    )).toList();
  }
}
