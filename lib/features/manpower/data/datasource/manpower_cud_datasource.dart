import 'package:dio/dio.dart';
import '../models/manpower_item.dart';
import '../../../../core/network/network_exception.dart';

class ManpowerCudDatasource {
  final Dio _dio;

  ManpowerCudDatasource(this._dio);

  Future<List<ManpowerItem>> getAll({String? section, String? crew, int page = 1, int pageSize = 500}) async {
    try {
      final params = <String, dynamic>{'page': page, 'page_size': pageSize};
      if (section != null) params['section'] = section;
      if (crew != null) params['crew'] = crew;
      final response = await _dio.get('/manpower', queryParameters: params);
      final data = response.data as Map<String, dynamic>;
      return (data['data'] as List? ?? [])
          .map((e) => ManpowerItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ManpowerItem> getById(int id) async {
    try {
      final response = await _dio.get('/manpower/$id');
      return ManpowerItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ManpowerItem> create(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/manpower/single', data: data);
      return ManpowerItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ManpowerItem> update(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/manpower/$id', data: data);
      return ManpowerItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(int id) async {
    try {
      await _dio.delete('/manpower/$id');
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
