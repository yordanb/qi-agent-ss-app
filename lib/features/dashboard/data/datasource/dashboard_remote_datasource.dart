import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../models/dashboard_stats_model.dart';
import '../models/monthly_stats_model.dart';

class DashboardRemoteDatasource {
  final Dio _dio;

  DashboardRemoteDatasource(this._dio);

  Future<DashBoardStatsModel> getStats(String nrp) async {
    try {
      final response = await _dio.get('${ApiConstants.ssStats}/$nrp');
      return DashBoardStatsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<MonthlyStatsModel> getMonthlyStats(String nrp, int year, int month) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.ssMonthlyStats}/$nrp/monthly',
        queryParameters: {'year': year, 'month': month},
      );
      return MonthlyStatsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  NetworkException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException.timeout();
    }
    if (e.type == DioExceptionType.connectionError) {
      return NetworkException.noConnection();
    }
    final code = e.response?.statusCode;
    final body = e.response?.data?.toString() ?? e.message ?? '';
    if (code != null) return NetworkException.fromHttpError(code, body);
    return NetworkException(message: e.message ?? 'Unknown error');
  }
}
