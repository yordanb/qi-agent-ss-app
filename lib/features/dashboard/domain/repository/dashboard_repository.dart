import '../entities/dashboard_stats.dart';

abstract class DashboardRepository {
  Future<DashboardStats> getStats(String nrp);
  Future<MonthlyStats> getMonthlyStats(String nrp, int year, int month);
}
