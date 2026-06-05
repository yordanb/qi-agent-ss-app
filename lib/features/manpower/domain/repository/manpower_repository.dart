import '../../data/datasource/manpower_remote_datasource.dart';
import '../entities/manpower_coverage.dart';

class ManpowerRepository {
  final ManpowerRemoteDatasource _datasource;

  ManpowerRepository(this._datasource);

  Future<List<ManpowerCoverage>> getCoverageSummary(int year, int month) async {
    final model = await _datasource.getCoverageSummary(year, month);
    return model.data
        .map((s) => ManpowerCoverage(
              crew: s.crew,
              totalPeople: s.totalPeople,
              totalSs: s.totalSs,
              totalTarget: s.totalTarget,
              coveragePct: s.coveragePct,
            ))
        .toList();
  }

  Future<List<CrewCoverage>> getCrewCoverage(String? section, int year, int month) async {
    final models = await _datasource.getCrewCoverage(section, year, month);
    return models
        .map((c) => CrewCoverage(
              crew: c.crew,
              section: c.section,
              totalPeople: c.totalPeople,
              totalSs: c.totalSs,
              targetSs: c.targetSs,
              coveragePct: c.coveragePct,
            ))
        .toList();
  }

  Future<ManpowerDetail> getNrpCoverage(String nrp, int year, int month) async {
    final m = await _datasource.getNrpCoverage(nrp, year, month);
    return ManpowerDetail(
      nrp: m.nrp,
      nama: m.nama,
      section: m.section,
      crew: m.crew,
      posisi: m.posisi,
      jabatan: m.jabatan,
      status: m.status,
      targetSs: m.targetSs,
      ssCount: m.ssCount,
      coveragePct: m.coveragePct,
    );
  }
}
