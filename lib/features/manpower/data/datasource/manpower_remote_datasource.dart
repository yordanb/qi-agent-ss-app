import 'package:dio/dio.dart';
import '../../../../core/network/network_exception.dart';
import '../models/manpower_models.dart';

class ManpowerRemoteDatasource {
  final Dio _dio;

  ManpowerRemoteDatasource(this._dio);

  Future<CoverageSummaryModel> getCoverageSummary(int year, int month) async {
    try {
      final response = await _dio.get(
        '/manpower/coverage/summary',
        queryParameters: {'year': year, 'month': month},
      );
      return CoverageSummaryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CrewCoverageModel>> getCrewCoverage(String? section, int year, int month) async {
    try {
      final params = <String, dynamic>{'year': year, 'month': month};
      if (section != null) params['section'] = section;
      final response = await _dio.get('/manpower/coverage/section', queryParameters: params);
      final data = response.data as Map<String, dynamic>;
      return (data['data'] as List? ?? [])
          .map((e) => CrewCoverageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ManpowerDetailModel> getNrpCoverage(String nrp, int year, int month) async {
    try {
      final response = await _dio.get(
        '/manpower/coverage/nrp/$nrp',
        queryParameters: {'year': year, 'month': month},
      );
      return ManpowerDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  NetworkException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
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
