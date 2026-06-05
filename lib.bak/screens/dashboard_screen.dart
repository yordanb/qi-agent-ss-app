import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'login_screen.dart';
import 'ss_list_screen.dart';
import 'esic_screen.dart';
import 'change_password_screen.dart';
import 'approval_pin_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String nrp;
  final Map<String, dynamic>? stats;
  final String? nama;
  final bool isAdmin;

  const DashboardScreen({
    super.key,
    required this.nrp,
    this.stats,
    this.nama,
    this.isAdmin = false,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<dynamic>? _esicSnapshots;
  bool _loadingEsic = true;

  // Monthly SS data
  Map<String, dynamic>? _monthlyStats;
  Map<String, dynamic>? _baseStats;
  bool _loadingMonthly = true;
  bool _loadingBase = true;
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  final List<Map<String, dynamic>> _months = [];

  @override
  void initState() {
    super.initState();
    _loadEsic();
    _initMonths();
    _loadBaseStats();
    _loadMonthlyStats();
  }

  Future<void> _loadBaseStats() async {
    try {
      if (_nrp.isEmpty) {
        if (mounted) setState(() { _baseStats = null; _loadingBase = false; });
        return;
      }
      final data = await ApiService.getSsStats(_nrp);
      if (mounted) setState(() { _baseStats = data; _loadingBase = false; });
    } catch (_) {
      if (mounted) setState(() { _baseStats = null; _loadingBase = false; });
    }
  }

  void _initMonths() {
    // Generate 12 months backwards from current month
    final now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      final m = DateTime(now.year, now.month - i, 1);
      _months.add({
        'year': m.year,
        'month': m.month,
        'label': DateFormat('MMM yyyy').format(m),
      });
    }
  }

  String get _nrp => widget.nrp.isNotEmpty ? widget.nrp : (ApiService.authNrp ?? '');

  Future<void> _loadEsic() async {
    try {
      if (_nrp.isEmpty) {
        if (mounted) setState(() { _esicSnapshots = []; _loadingEsic = false; });
        return;
      }
      final data = await ApiService.getEsicByNrp(_nrp);
      if (mounted) setState(() => _esicSnapshots = data);
    } catch (_) {
      if (mounted) setState(() => _esicSnapshots = []);
    } finally {
      if (mounted) setState(() => _loadingEsic = false);
    }
  }

  Future<void> _loadMonthlyStats() async {
    setState(() => _loadingMonthly = true);
    try {
      final data = await ApiService.getSsMonthlyStats(
          widget.nrp, _selectedMonth.year, _selectedMonth.month);
      if (mounted) setState(() => _monthlyStats = data);
    } catch (_) {
      if (mounted) setState(() => _monthlyStats = null);
    } finally {
      if (mounted) setState(() => _loadingMonthly = false);
    }
  }

  void _changeMonth(DateTime month) {
    setState(() => _selectedMonth = month);
    _loadMonthlyStats();
  }

  @override
  Widget build(BuildContext context) {
    final stats = _baseStats ?? widget.stats ?? {};
    final nama = widget.nama ?? stats['nama'] ?? '-';
    final dept = stats['dept'] ?? '-';
    final lastUpdate = stats['last_update'] ?? '-';

    // Monthly data or fallback to all-time
    final ms = _monthlyStats ?? stats;
    final totalSs = ms['total_ss'] ?? 0;
    final closed = ms['closed'] ?? 0;
    final waitApproval = ms['wait_approval'] ?? 0;
    final other = ms['other'] ?? 0;

    final screens = [
      _buildDashboard(nama, dept, totalSs, closed, waitApproval, other, lastUpdate),
      SsListScreen(nrp: _nrp),
      EsicScreen(
        nrp: widget.nrp,
        snapshots: _esicSnapshots ?? [],
        isLoading: _loadingEsic,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quality Innovation — $nama'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _loadEsic();
              _loadMonthlyStats();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Dashboard Departemen',
            onPressed: () {
              context.push('/dept-dashboard');
            },
          ),
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.verified_user),
              tooltip: 'Approval PIN',
              onPressed: () {
                context.push('/approval-pin');
              },
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'approval_pin') {
                context.push('/approval-pin');
              } else if (value == 'dept_dashboard') {
                context.push('/dept-dashboard');
              } else if (value == 'change_password') {
                context.push('/change-password',
                    extra: {'nrp': widget.nrp});
              } else if (value == 'logout') {
                ApiService.logout();
                context.go('/login');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'approval_pin',
                child: Row(
                  children: [
                    Icon(Icons.verified_user, size: 20),
                    SizedBox(width: 8),
                    Text('Approval PIN'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'dept_dashboard',
                child: Row(
                  children: [
                    Icon(Icons.bar_chart, size: 20),
                    SizedBox(width: 8),
                    Text('Dashboard Departemen'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'change_password',
                child: Row(
                  children: [
                    Icon(Icons.lock_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Ganti Password'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'SS'),
          NavigationDestination(icon: Icon(Icons.description), label: 'ESIC'),
        ],
      ),
    );
  }

  Widget _buildDashboard(String nama, String dept, int totalSs, int closed,
      int waitApproval, int other, String lastUpdate) {
    final monthLabel = DateFormat('MMMM yyyy').format(_selectedMonth);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blueGrey[100],
                    child: Text(nama.toString().substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nama.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('NRP: ${widget.nrp} • Dept: $dept',
                            style: TextStyle(color: Colors.grey[600])),
                        Text('Update: $lastUpdate',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // SS Stats — 4 icons sejajar
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      _iconStat(Icons.assignment, 'Total', totalSs, Colors.blueGrey),
                      _iconStat(Icons.check_circle, 'Approved', closed, Colors.green),
                      _iconStat(Icons.hourglass_top, 'Waiting', waitApproval, Colors.indigo),
                      _iconStat(Icons.pending, 'Other', other, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Month label
                  Text(monthLabel,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Month picker — horizontal scrollable chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _months.length,
              itemBuilder: (context, i) {
                final m = _months[i];
                final isSelected = m['year'] == _selectedMonth.year &&
                    m['month'] == _selectedMonth.month;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(m['label'],
                        style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.blueGrey)),
                    selected: isSelected,
                    selectedColor: Colors.blueGrey[700],
                    onSelected: (_) => _changeMonth(
                        DateTime(m['year'], m['month'], 1)),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ESIC Summary
          const Text('ESIC TM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_loadingEsic)
            const Center(child: CircularProgressIndicator())
          else if (_esicSnapshots == null || _esicSnapshots!.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.grey),
                    const SizedBox(width: 12),
                    const Text('Belum ada data ESIC'),
                  ],
                ),
              ),
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_esicSnapshots!.length} snapshot tersedia',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...(_esicSnapshots!.take(3).map((s) {
                      final date = s['snapshot_date'] ?? '-';
                      final accCount = (s['dokumen_diakses'] ?? '')
                          .toString()
                          .split('\n')
                          .where((d) => d.trim().isNotEmpty)
                          .length;
                      final mtdCount = (s['dokumen_mtd'] ?? '')
                          .toString()
                          .split('\n')
                          .where((d) => d.trim().isNotEmpty)
                          .length;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                            '• $date — $accCount diakses, $mtdCount MTD',
                            style: TextStyle(color: Colors.grey[600])),
                      );
                    })),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _iconStat(IconData icon, String label, int value, Color color) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 4),
          Text('$value',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label,
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
