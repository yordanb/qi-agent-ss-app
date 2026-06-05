import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';

class DeptDashboardScreen extends StatefulWidget {
  const DeptDashboardScreen({super.key});

  @override
  State<DeptDashboardScreen> createState() => _DeptDashboardScreenState();
}

class _DeptDashboardScreenState extends State<DeptDashboardScreen> {
  String _selectedDept = 'SPL2';
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  Map<String, dynamic>? _stats;
  List<_DailyData> _dailyData = [];
  bool _loading = true;
  String? _error;

  final _depts = ['SPL2', 'STYR'];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    print('[DEPT-DASH] _fetchData called dept=$_selectedDept year=$_selectedYear month=$_selectedMonth');
    setState(() { _loading = true; _error = null; });
    try {
      final stats = await ApiService.getDeptStatsMonthly(
        _selectedDept, _selectedYear, _selectedMonth,
      );
      final daily = await ApiService.getDeptDaily(
        _selectedDept, _selectedYear, _selectedMonth,
      );
      if (!mounted) return;
      print('[DEPT-DASH] OK stats=$stats daily=${daily.length}');
      setState(() {
        _loading = false;
        _stats = stats;
        _dailyData = daily.map((d) => _DailyData(
          d['day'] as int,
          d['count'] as int,
        )).toList();
      });
    } catch (e, stack) {
      print('[DEPT-DASH] ERROR: $e');
      print('[DEPT-DASH] STACK: $stack');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ERR: ' + e.toString().substring(0, e.toString().length.clamp(0, 200)), style: TextStyle(fontSize: 12)), backgroundColor: Colors.red, duration: Duration(seconds: 10)),
      );
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Departemen'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/dashboard');
            }
          },
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text('Error: $_error', style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    FilledButton(onPressed: _fetchData, child: const Text('Coba Lagi')),
                  ],
                ))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilters(),
                      const SizedBox(height: 20),
                      _buildStatsCards(),
                      const SizedBox(height: 24),
                      _buildChart(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedDept,
            decoration: const InputDecoration(
              labelText: 'Departemen',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: _depts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
            onChanged: (v) { _selectedDept = v!; _fetchData(); },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            value: _selectedMonth,
            decoration: const InputDecoration(
              labelText: 'Bulan',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: List.generate(12, (i) => i + 1).map((m) => DropdownMenuItem(
              value: m, child: Text(_monthName(m)),
            )).toList(),
            onChanged: (v) { _selectedMonth = v!; _fetchData(); },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            value: _selectedYear,
            decoration: const InputDecoration(
              labelText: 'Tahun',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: [2025, 2026].map((y) => DropdownMenuItem(value: y, child: Text('$y'))).toList(),
            onChanged: (v) { _selectedYear = v!; _fetchData(); },
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    final approved = _stats?['approved'] ?? 0;
    final waiting = _stats?['waiting'] ?? 0;
    final total = approved + waiting;

    return Row(
      children: [
        Expanded(child: _statCard('Total', total, Colors.blueGrey, Icons.assignment)),
        const SizedBox(width: 12),
        Expanded(child: _statCard('Approved', approved, Colors.green, Icons.check_circle)),
        const SizedBox(width: 12),
        Expanded(child: _statCard('Wait', waiting, Colors.indigo, Icons.hourglass_top)),
      ],
    );
  }

  Widget _statCard(String label, int value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text('$value', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildChart() {
    if (_dailyData.isEmpty) {
      return const Center(child: Padding(
        padding: EdgeInsets.all(32),
        child: Text('Tidak ada data untuk bulan ini'),
      ));
    }

    final maxCount = _dailyData.map((d) => d.count).reduce((a, b) => a > b ? a : b);
    final totalCount = _dailyData.fold(0, (sum, d) => sum + d.count);
    final avg = _dailyData.isNotEmpty ? (totalCount / _dailyData.length).toStringAsFixed(1) : '0';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${_monthName(_selectedMonth)} $_selectedYear',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: (_dailyData.length * 40.0).clamp(300.0, 900.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Y-axis labels
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _dailyData.map((d) {
                        final barH = maxCount > 0 ? (d.count / maxCount) * 200.0 : 0.0;
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${d.count}',
                                  style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                              Container(
                                height: barH.clamp(2.0, 200.0),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('${d.day}',
                                  style: TextStyle(fontSize: 9, color: Colors.grey[600])),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: $totalCount SS',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text('Rata-rata: $avg/hari',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ],
    );
  }

  String _monthName(int m) {
    const names = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
    return names[m - 1];
  }
}

class _DailyData {
  final int day;
  final int count;
  _DailyData(this.day, this.count);
}
