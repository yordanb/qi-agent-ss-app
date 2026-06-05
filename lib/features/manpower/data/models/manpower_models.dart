class CoverageSummaryModel {
  final int year;
  final int month;
  final List<SectionCoverageModel> data;

  const CoverageSummaryModel({
    required this.year,
    required this.month,
    required this.data,
  });

  factory CoverageSummaryModel.fromJson(Map<String, dynamic> json) {
    return CoverageSummaryModel(
      year: json['year'] as int? ?? 2026,
      month: json['month'] as int? ?? 1,
      data: (json['data'] as List? ?? [])
          .map((e) => SectionCoverageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SectionCoverageModel {
  final String crew;
  final int totalPeople;
  final int totalSs;
  final int totalTarget;
  final double coveragePct;

  const SectionCoverageModel({
    required this.crew,
    required this.totalPeople,
    required this.totalSs,
    required this.totalTarget,
    required this.coveragePct,
  });

  factory SectionCoverageModel.fromJson(Map<String, dynamic> json) {
    return SectionCoverageModel(
      crew: json['crew'] as String? ?? '-',
      totalPeople: (json['total_people'] as num?)?.toInt() ?? 0,
      totalSs: (json['total_ss'] as num?)?.toInt() ?? 0,
      totalTarget: (json['total_target'] as num?)?.toInt() ?? 0,
      coveragePct: (json['coverage_pct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CrewCoverageModel {
  final String crew;
  final String section;
  final int totalPeople;
  final int totalSs;
  final int targetSs;
  final double coveragePct;

  const CrewCoverageModel({
    required this.crew,
    required this.section,
    required this.totalPeople,
    required this.totalSs,
    required this.targetSs,
    required this.coveragePct,
  });

  factory CrewCoverageModel.fromJson(Map<String, dynamic> json) {
    return CrewCoverageModel(
      crew: json['crew'] as String? ?? '-',
      section: json['section'] as String? ?? '-',
      totalPeople: (json['total_people'] as num?)?.toInt() ?? 0,
      totalSs: (json['total_ss'] as num?)?.toInt() ?? 0,
      targetSs: (json['target_ss'] as num?)?.toInt() ?? 0,
      coveragePct: (json['coverage_pct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class ManpowerDetailModel {
  final String nrp;
  final String nama;
  final String section;
  final String? crew;
  final String? posisi;
  final String? jabatan;
  final String? status;
  final int targetSs;
  final int ssCount;
  final double coveragePct;

  const ManpowerDetailModel({
    required this.nrp,
    required this.nama,
    required this.section,
    this.crew,
    this.posisi,
    this.jabatan,
    this.status,
    required this.targetSs,
    required this.ssCount,
    required this.coveragePct,
  });

  factory ManpowerDetailModel.fromJson(Map<String, dynamic> json) {
    return ManpowerDetailModel(
      nrp: json['nrp'] as String? ?? '',
      nama: json['nama'] as String? ?? '-',
      section: json['section'] as String? ?? '-',
      crew: json['crew'] as String?,
      posisi: json['posisi'] as String?,
      jabatan: json['jabatan'] as String?,
      status: json['status'] as String?,
      targetSs: (json['target_ss'] as num?)?.toInt() ?? 0,
      ssCount: (json['ss_count'] as num?)?.toInt() ?? 0,
      coveragePct: (json['coverage_pct'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
