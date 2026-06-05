import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://qi.mibt.my.id/api';

class ApiService {
  static String? _authNrp;
  static String? _authPassword;
  static bool _isAdmin = false;

  static String? get authNrp => _authNrp;
  static bool get isAdmin => _isAdmin;

  static void setAuth(String nrp, String password, {bool isAdmin = false}) {
    _authNrp = nrp;
    _authPassword = password;
    _isAdmin = isAdmin;
  }

  static void logout() {
    _authNrp = null;
    _authPassword = null;
    _isAdmin = false;
  }

  static Future<Map<String, dynamic>> _post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    final err = jsonDecode(response.body);
    throw Exception(err['detail'] ?? 'Error ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> _get(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    final response = await http.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    final err = jsonDecode(response.body);
    throw Exception(err['detail'] ?? 'Error ${response.statusCode}');
  }

  static Future<List<dynamic>> _getList(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    final response = await http.get(uri, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    final err = jsonDecode(response.body);
    throw Exception(err['detail'] ?? 'Error ${response.statusCode}');
  }

  // --- Auth ---

  static Future<Map<String, dynamic>> login(String nrp, String password) async {
    final result = await _post('/auth/login', {'nrp': nrp, 'password': password});
    _authNrp = nrp;
    _authPassword = password;
    _isAdmin = result['is_admin'] ?? false;
    return result;
  }

  static Future<Map<String, dynamic>> changePassword(
      String nrp, String oldPassword, String newPassword) async {
    return _post('/auth/change-password', {
      'nrp': nrp,
      'old_password': oldPassword,
      'new_password': newPassword,
    });
  }

  static Future<Map<String, dynamic>> adminResetPassword(
      String adminNrp, String adminPassword, String targetNrp, String newPassword) async {
    return _post('/auth/admin/reset-password', {
      'admin_nrp': adminNrp,
      'admin_password': adminPassword,
      'target_nrp': targetNrp,
      'new_password': newPassword,
    });
  }

  static Future<List<dynamic>> listUsers(String adminNrp, String adminPassword) async {
    return _getList('/auth/users', params: {
      'admin_nrp': adminNrp,
      'admin_password': adminPassword,
    });
  }

  // --- SS ---

  static Future<Map<String, dynamic>> getSsStats(String nrp) async {
    return _get('/ss/stats/$nrp');
  }

  static Future<Map<String, dynamic>> getSsByNrp(String nrp,
      {int page = 1, int pageSize = 50}) async {
    return _get('/ss/by-nrp/$nrp',
        params: {'page': '$page', 'page_size': '$pageSize'});
  }

  static Future<Map<String, dynamic>> getSsList({
    String? nrp,
    String? dept,
    String? source,
    String? status,
    String? grade,
    String? startDate,
    String? endDate,
    String? search,
    int page = 1,
    int pageSize = 50,
  }) async {
    final params = <String, String>{'page': '$page', 'page_size': '$pageSize'};
    if (nrp != null) params['nrp'] = nrp;
    if (dept != null) params['dept'] = dept;
    if (source != null) params['source'] = source;
    if (status != null) params['status'] = status;
    if (grade != null) params['grade'] = grade;
    if (startDate != null) params['start_date'] = startDate;
    if (endDate != null) params['end_date'] = endDate;
    if (search != null) params['search'] = search;
    return _get('/ss/', params: params);
  }

  static Future<Map<String, dynamic>> getSsMonthlyStats(String nrp, int year, int month) async {
    return _get('/ss/stats/$nrp/monthly',
        params: {'year': '$year', 'month': '$month'});
  }

  // --- Upload Approval ---

  static Future<Map<String, dynamic>> getApprovalPin(String token) async {
    return _get('/upload/pin', params: {'token': token});
  }

  static Future<Map<String, dynamic>> approveUpload(
      String token, String pin, String nrp) async {
    final uri = Uri.parse('$baseUrl/upload/approve');
    final response = await http.post(uri, body: {
      'token': token,
      'pin': pin,
      'nrp': nrp,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    final err = jsonDecode(response.body);
    throw Exception(err['detail'] ?? 'Error ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> rejectUpload(String token) async {
    final uri = Uri.parse('$baseUrl/upload/reject');
    final response = await http.post(uri, body: {'token': token});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Error ${response.statusCode}');
  }

  static Future<List<dynamic>> getDeptStats({String? dept, String? distrik}) async {
    final params = <String, String>{};
    if (dept != null) params['dept'] = dept;
    if (distrik != null) params['distrik'] = distrik;
    return _getList('/ss/stats', params: params.isNotEmpty ? params : null);
  }

  // --- ESIC ---

  static Future<List<dynamic>> getEsicByNrp(String nrp) async {
    return _getList('/esic/by-nrp/$nrp');
  }

  static Future<Map<String, dynamic>> getEsicDocuments(
      String nrp, int year, int month) async {
    return _get('/esic/documents',
        params: {'nrp': nrp, 'year': '$year', 'month': '$month'});
  }

  static Future<Map<String, dynamic>> compareEsic(
      String nrp, String fromDate, String toDate) async {
    return _get('/esic/compare',
        params: {'nrp': nrp, 'from_date': fromDate, 'to_date': toDate});
  }

  static Future<Map<String, dynamic>> checkProgress(
      String nrp, String fromDate, String toDate) async {
    return _get('/esic/progress',
        params: {'nrp': nrp, 'from_date': fromDate, 'to_date': toDate});
  }

  // ── Dashboard Departemen ──────────────────────────────
  static Future<Map<String, dynamic>> getDeptStatsMonthly(String dept, int year, int month) async {
    return _get('/ss/dept/stats/$dept',
        params: {'year': year.toString(), 'month': month.toString()});
  }

  static Future<List<Map<String, dynamic>>> getDeptDaily(String dept, int year, int month) async {
    final result = await _getList('/ss/dept/daily/$dept',
        params: {'year': year.toString(), 'month': month.toString()});
    return List<Map<String, dynamic>>.from(result);
  }
}