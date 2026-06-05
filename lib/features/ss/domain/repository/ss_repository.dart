import '../entities/ss.dart';

abstract class SsRepository {
  Future<SsPage> getSsByNrp(String nrp, int page);
}
