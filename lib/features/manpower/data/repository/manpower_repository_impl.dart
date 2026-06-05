import '../datasource/manpower_remote_datasource.dart';
import '../models/manpower_models.dart';

class ManpowerRepositoryImpl {
  final ManpowerRemoteDatasource _datasource;

  ManpowerRepositoryImpl(this._datasource);

  Future<CoverageSummaryModel> getCoverageSummary(int year, int month) {
    return _datasource.getCoverageSummary(year, month);
  }

  Future<List<CrewCoverageModel>> getCrewCoverage(String? section, int year, int month) {
    return _datasource.getCrewCoverage(section, year, month);
  }

  Future<ManpowerDetailModel> getNrpCoverage(String nrp, int year, int month) {
    return _datasource.getNrpCoverage(nrp, year, month);
  }
}
