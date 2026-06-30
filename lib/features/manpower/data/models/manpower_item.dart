class ManpowerItem {
  final int id;
  final String nrp;
  final String nama;
  final String section;
  final String crew;
  final String posisi;
  final int targetSs;
  final String status;
  final String jabatan;
  final bool isActive;

  const ManpowerItem({
    required this.id,
    required this.nrp,
    required this.nama,
    required this.section,
    required this.crew,
    required this.posisi,
    required this.targetSs,
    required this.status,
    required this.jabatan,
    required this.isActive,
  });

  factory ManpowerItem.fromJson(Map<String, dynamic> json) {
    return ManpowerItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nrp: json['nrp'] as String? ?? '',
      nama: json['nama'] as String? ?? '',
      section: json['section'] as String? ?? '',
      crew: json['crew'] as String? ?? '',
      posisi: json['posisi'] as String? ?? '',
      targetSs: (json['target_ss'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      jabatan: json['jabatan'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}
