import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

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
  List<dynamic> _daily = [];
  bool _loadingStats = true;
  bool _loadingDaily = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loadingStats = true; _loadingDaily = true; _error = null; });
    try {
      final dio = Dio(BaseOptions(
        baseUrl: 'https://qi.mibt.my.id/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ));
      final statsRes = await dio.get('${ApiConstants.deptStats}/$_selectedDept', queryParameters: {'year': _selectedYear, 'month': _selectedMonth});
      if (mounted) setState(() { _stats = statsRes.data; _loadingStats = false; });
      final dailyRes = await dio.get('${ApiConstants.deptDaily}/$_selectedDept', queryParameters: {'year': _selectedYear, 'month': _selectedMonth});
      if (mounted) setState(() { _daily = dailyRes.data; _loadingDaily = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loadingStats = false; _loadingDaily = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Departemen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () { if (context.canPop()) context.pop(); else context.go('/dashboard'); },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDept,
                    decoration: const InputDecoration(labelText: 'Departemen', border: OutlineInputBorder()),
                    items: ['SPL2', 'STYR'].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (v) { setState(() => _selectedDept = v!); _load(); },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedMonth,
                    decoration: const InputDecoration(labelText: 'Bulan', border: OutlineInputBorder()),
                    items: List.generate(12, (i) => i + 1).map((m) => DropdownMenuItem(value: m, child: Text(m.toString().padLeft(2, '0')))).toList(),
                    onChanged: (v) { setState(() => _selectedMonth = v!); _load(); },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedYear,
                    decoration: const InputDecoration(labelText: 'Tahun', border: OutlineInputBorder()),
                    items: [2025, 2026].map((y) => DropdownMenuItem(value: y, child: Text(y.toString()))).toList(),
                    onChanged: (v) { setState(() => _selectedYear = v!); _load(); },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_loadingStats)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Column(children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text('Error: $_error', style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _load, child: const Text('Coba Lagi')),
              ])
            else if (_stats != null)
              _buildStatCards(_stats!),
            const SizedBox(height: 24),
            const Text('Grafik Harian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_loadingDaily)
              const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()))
            else
              _buildBarChart(_daily),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(Map<String, dynamic> stats) {
    final approved = stats['approved'] ?? 0;
    final waiting = stats['waiting'] ?? 0;
    final total = approved + waiting;
    return Row(
      children: [
        _statCard('Total', total, Colors.blue),
        _statCard('Approved', approved, Colors.green),
        _statCard('Waiting', waiting, Colors.indigo),
      ],
    );
  }

  Widget _statCard(String label, int value, Color color) {
    return Expanded(
      child: Card(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('$value', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ]),
      )),
    );
  }

  Widget _buildBarChart(List<dynamic> daily) {
    if (daily.isEmpty) return const Text('Tidak ada data');
    final maxCount = daily.map((d) => (d['count'] as int? ?? 0)).fold<int>(0, (a, b) => a > b ? a : b);
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daily.length,
        itemBuilder: (context, i) {
          final d = daily[i];
          final day = d['day'] as int? ?? 0;
          final count = d['count'] as int? ?? 0;
          final barH = maxCount > 0 ? (count / maxCount) * 180.0 : 0.0;
          return SizedBox(
            width: 36,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('$count', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  width: 24,
                  height: barH.clamp(2.0, 180.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Text('$day', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
              ],
            ),
          );
        },
      ),
    );
  }
}
