import '../entities/snapshot.dart';

abstract class EsicRepository {
  Future<List<Snapshot>> getSnapshots(String nrp);
}
