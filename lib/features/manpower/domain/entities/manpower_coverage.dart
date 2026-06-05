class ManpowerCoverage {
  final String crew;
  final int totalPeople;
  final int totalSs;
  final int totalTarget;
  final double coveragePct;

  const ManpowerCoverage({
    required this.crew,
    required this.totalPeople,
    required this.totalSs,
    required this.totalTarget,
    required this.coveragePct,
  });
}

class CrewCoverage {
  final String crew;
  final String section;
  final int totalPeople;
  final int totalSs;
  final int targetSs;
  final double coveragePct;

  const CrewCoverage({
    required this.crew,
    required this.section,
    required this.totalPeople,
    required this.totalSs,
    required this.targetSs,
    required this.coveragePct,
  });
}

class ManpowerDetail {
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

  const ManpowerDetail({
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
}
