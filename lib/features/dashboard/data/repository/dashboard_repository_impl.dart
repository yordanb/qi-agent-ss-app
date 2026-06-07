import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasource/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource _datasource;

  DashboardRepositoryImpl(this._datasource);

  @override
  Future<DashboardStats> getStats(String nrp) async {
    final model = await _datasource.getStats(nrp);
    return DashboardStats(
      nrp: model.nrp,
      nama: model.nama,
      dept: model.dept,
      totalSs: model.totalSs,
      closed: model.closed,
      open: model.open,
      other: model.other,
      lastUpdate: model.lastUpdate,
    );
  }

  @override
  Future<MonthlyStats> getMonthlyStats(String nrp, int year, int month) async {
    final model = await _datasource.getMonthlyStats(nrp, year, month);
    return MonthlyStats(
      total: model.totalSs ?? 0,
      approved: model.closed ?? 0,
      waiting: model.open ?? 0,
      other: model.other ?? 0,
    );
  }
}
