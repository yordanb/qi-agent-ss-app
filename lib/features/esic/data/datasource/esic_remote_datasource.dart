import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../models/snapshot_model.dart';

class EsicRemoteDatasource {
  final Dio _dio;

  EsicRemoteDatasource(this._dio);

  Future<List<SnapshotModel>> getSnapshots(String nrp) async {
    try {
      final response = await _dio.get('${ApiConstants.esicByNrp}/$nrp');
      final data = response.data;
      List list;
      if (data is List) {
        list = data;
      } else if (data is Map && data.containsKey('data')) {
        list = data['data'] as List;
      } else {
        list = [];
      }
      return list.map((e) => SnapshotModel.fromJson(e as Map<String, dynamic>)).toList();
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
