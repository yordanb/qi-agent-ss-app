class DashboardStats {
  final String nrp;
  final String nama;
  final String dept;
  final int totalSs;
  final int closed;
  final int outstanding;
  final int waitApproval;
  final int other;
  final String? lastUpdate;

  const DashboardStats({
    required this.nrp,
    required this.nama,
    required this.dept,
    required this.totalSs,
    required this.closed,
    required this.outstanding,
    required this.waitApproval,
    required this.other,
    this.lastUpdate,
  });
}

class MonthlyStats {
  final int total;
  final int approved;
  final int waiting;
  final int other;

  const MonthlyStats({
    required this.total,
    required this.approved,
    required this.waiting,
    required this.other,
  });
}
