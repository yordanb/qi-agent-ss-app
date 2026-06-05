class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const NetworkException({required this.message, this.statusCode, this.data});

  factory NetworkException.fromHttpError(int code, String body) {
    String msg;
    switch (code) {
      case 400:
        msg = 'Request tidak valid';
        break;
      case 401:
        msg = 'Sesi habis, silakan login ulang';
        break;
      case 403:
        msg = 'Tidak memiliki akses';
        break;
      case 404:
        msg = 'Data tidak ditemukan';
        break;
      case 422:
        msg = 'Data tidak valid';
        break;
      case 500:
        msg = 'Server error';
        break;
      default:
        msg = 'Terjadi kesalahan ($code)';
    }
    return NetworkException(message: msg, statusCode: code, data: body);
  }

  factory NetworkException.timeout() {
    return const NetworkException(message: 'Koneksi timeout');
  }

  factory NetworkException.noConnection() {
    return const NetworkException(message: 'Tidak ada koneksi internet');
  }

  @override
  String toString() => message;
}
