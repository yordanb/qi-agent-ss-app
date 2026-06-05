class Ss {
  final String noSs;
  final String judul;
  final String nrp;
  final String? nama;
  final String? dept;
  final String? currentStatus;
  final String? source;
  final String? tanggalLaporan;

  const Ss({
    required this.noSs,
    required this.judul,
    required this.nrp,
    this.nama,
    this.dept,
    this.currentStatus,
    this.source,
    this.tanggalLaporan,
  });

  String get statusCategory {
    final s = (currentStatus ?? '').toLowerCase();
    if (s.contains('approved') || s.contains('closed')) return 'approved';
    if (s.contains('menunggu') || s.contains('wait') || s.contains('pending')) return 'waiting';
    return 'other';
  }
}

class SsPage {
  final int total;
  final int page;
  final int pageSize;
  final List<Ss> items;

  const SsPage({required this.total, required this.page, required this.pageSize, required this.items});
}
