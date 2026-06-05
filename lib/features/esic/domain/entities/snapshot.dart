class Snapshot {
  final int? id;
  final String nrp;
  final String? nama;
  final String? dept;
  final String? snapshotDate;
  final String? dokumenDiakses;
  final String? dokumenMtd;

  const Snapshot({
    this.id,
    required this.nrp,
    this.nama,
    this.dept,
    this.snapshotDate,
    this.dokumenDiakses,
    this.dokumenMtd,
  });

  int get accCount => (dokumenDiakses ?? '').split('\n').where((d) => d.trim().isNotEmpty).length;
  int get mtdCount => (dokumenMtd ?? '').split('\n').where((d) => d.trim().isNotEmpty).length;
}
