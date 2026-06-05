import '../../domain/entities/ss.dart';
import '../../domain/repository/ss_repository.dart';
import '../datasource/ss_remote_datasource.dart';
import '../models/ss_model.dart';

class SsRepositoryImpl implements SsRepository {
  final SsRemoteDatasource _datasource;

  SsRepositoryImpl(this._datasource);

  @override
  Future<SsPage> getSsByNrp(String nrp, int page) async {
    final model = await _datasource.getSsByNrp(nrp, page);
    return SsPage(
      total: model.total,
      page: model.page,
      pageSize: model.pageSize,
      items: model.data.map((e) {
        final m = SsModel.fromJson(e as Map<String, dynamic>);
        return Ss(
          noSs: m.noSs,
          judul: m.judul,
          nrp: m.nrp,
          nama: m.nama,
          dept: m.dept,
          currentStatus: m.currentStatus,
          source: m.source,
          tanggalLaporan: m.tanggalLaporan,
        );
      }).toList(),
    );
  }
}
