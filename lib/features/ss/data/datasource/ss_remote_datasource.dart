import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../models/ss_page_model.dart';

class SsRemoteDatasource {
  final Dio _dio;

  SsRemoteDatasource(this._dio);

  Future<SsPageModel> getSsByNrp(String nrp, int page, {int pageSize = 50}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.ssByNrp}/$nrp',
        queryParameters: {'page': page, 'page_size': pageSize},
      );
      return SsPageModel.fromJson(response.data);
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
