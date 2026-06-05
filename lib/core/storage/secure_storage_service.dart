import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    try {
      await _storage.write(key: StorageKeys.accessToken, value: accessToken);
      await _storage.write(key: StorageKeys.refreshToken, value: refreshToken);
    } catch (_) {}
  }

  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: StorageKeys.accessToken);
    } catch (_) {
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: StorageKeys.refreshToken);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUser({required String nrp, required String nama, required bool isAdmin}) async {
    try {
      await _storage.write(key: StorageKeys.userNrp, value: nrp);
      await _storage.write(key: StorageKeys.userName, value: nama);
      await _storage.write(key: StorageKeys.isAdmin, value: isAdmin.toString());
    } catch (_) {}
  }

  Future<String?> getUserNrp() async {
    try {
      return await _storage.read(key: StorageKeys.userNrp);
    } catch (_) {
      return null;
    }
  }

  Future<String?> getUserName() async {
    try {
      return await _storage.read(key: StorageKeys.userName);
    } catch (_) {
      return null;
    }
  }

  Future<bool> getIsAdmin() async {
    try {
      return (await _storage.read(key: StorageKeys.isAdmin)) == 'true';
    } catch (_) {
      return false;
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (_) {}
  }
}
