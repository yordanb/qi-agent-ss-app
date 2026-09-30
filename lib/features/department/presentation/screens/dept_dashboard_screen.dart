import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

// State for department dashboard
class DeptDashboardState {
  final String selectedDept;
  final int selectedYear;
  final int selectedMonth;
  final Map<String, dynamic>? stats;
  final List<dynamic> daily;
  final Map<String, dynamic>? eiictmStats;
  final bool loadingStats;
  final bool loadingDaily;
  final bool loadingEiictm;
  final String? error;

  const DeptDashboardState({
    this.selectedDept = 'SPL2',
    this.selectedYear = 2025,
    this.selectedMonth = 1,
    this.stats,
    this.daily = const [],
    this.eiictmStats,
    this.loadingStats = true,
    this.loadingDaily = true,
    this.loadingEiictm = true,
    this.error,
  });

  DeptDashboardState copyWith({
    String? selectedDept,
    int? selectedYear,
    int? selectedMonth,
    Map<String, dynamic>? stats,
    List<dynamic>? daily,
    Map<String, dynamic>? eiictmStats,
    bool? loadingStats,
    bool? loadingDaily,
    bool? loadingEiictm,
    String? error,
  }) {
    return DeptDashboardState(
      selectedDept: selectedDept ?? this.selectedDept,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      stats: stats ?? this.stats,
      daily: daily ?? this.daily,
      eiictmStats: eiictmStats ?? this.eiictmStats,
      loadingStats: loadingStats ?? this.loadingStats,
      loadingDaily: loadingDaily ?? this.loadingDaily,
      loadingEiictm: loadingEiictm ?? this.loadingEiictm,
      error: error ?? this.error,
    );
  }
}

// Notifier for department dashboard (using Riverpod 2.x Notifier)
class DeptDashboardNotifier extends Notifier<DeptDashboardState> {
  @override
  DeptDashboardState build() {
    return DeptDashboardState(
      selectedYear: DateTime.now().year,
      selectedMonth: DateTime.now().month,
    );
  }

  Future<void> load() async {
    state = state.copyWith(
      loadingStats: true,
      loadingDaily: true,
      loadingEiictm: true,
      error: null,
    );
    try {
      final dio = ref.read(dioClientProvider).dio;
      final statsRes = await dio.get(
        '${ApiConstants.deptStats}/${state.selectedDept}',
        queryParameters: {'year': state.selectedYear, 'month': state.selectedMonth},
      );
      state = state.copyWith(stats: statsRes.data, loadingStats: false);

      final dailyRes = await dio.get(
        '${ApiConstants.deptDaily}/${state.selectedDept}',
        queryParameters: {'year': state.selectedYear, 'month': state.selectedMonth},
      );
      state = state.copyWith(daily: dailyRes.data, loadingDaily: false);

      final eiictmRes = await dio.get(
        '${ApiConstants.deptEiictm}/${state.selectedDept}',
        queryParameters: {'year': state.selectedYear, 'month': state.selectedMonth},
      );
      state = state.copyWith(eiictmStats: eiictmRes.data, loadingEiictm: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        loadingStats: false,
        loadingDaily: false,
        loadingEiictm: false,
      );
    }
  }

  void setDept(String dept) {
    state = state.copyWith(selectedDept: dept);
    load();
  }

  void setMonth(int month) {
    state = state.copyWith(selectedMonth: month);
    load();
  }

  void setYear(int year) {
    final dept = (year != 2025 && state.selectedDept == 'STYR') ? 'SPL2' : state.selectedDept;
    state = state.copyWith(selectedYear: year, selectedDept: dept);
    load();
  }
}

// Provider
final deptDashboardProvider = NotifierProvider<DeptDashboardNotifier, DeptDashboardState>(DeptDashboardNotifier.new);

class DeptDashboardScreen extends ConsumerWidget {
  const DeptDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deptDashboardProvider);
    final notifier = ref.read(deptDashboardProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Departemen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: state.selectedDept,
                    decoration: const InputDecoration(labelText: 'Departemen', border: OutlineInputBorder()),
                    items: [
                      'SPL2',
                      if (state.selectedYear == 2025) 'STYR',
                    ].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (v) => notifier.setDept(v!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: state.selectedMonth,
                    decoration: const InputDecoration(labelText: 'Bulan', border: OutlineInputBorder()),
                    items: List.generate(12, (i) => i + 1)
                        .map((m) => DropdownMenuItem(value: m, child: Text(m.toString().padLeft(2, '0'))))
                        .toList(),
                    onChanged: (v) => notifier.setMonth(v!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: state.selectedYear,
                    decoration: const InputDecoration(labelText: 'Tahun', border: OutlineInputBorder()),
                    items: [2025, 2026].map((y) => DropdownMenuItem(value: y, child: Text(y.toString()))).toList(),
                    onChanged: (v) => notifier.setYear(v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.loadingStats)
              const Center(child: CircularProgressIndicator())
            else if (state.error != null)
              Column(children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () => notifier.load(), child: const Text('Coba Lagi')),
              ])
            else if (state.stats != null)
              _buildStatCards(state.stats!),
            const SizedBox(height: 24),
            const Text('EIICTM Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (state.loadingEiictm)
              const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))
            else if (state.eiictmStats != null)
              _buildEiictmCard(state.eiictmStats!),
            const SizedBox(height: 24),
            const Text('Grafik Harian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (state.loadingDaily)
              const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()))
            else
              _buildBarChart(state.daily),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(Map<String, dynamic> stats) {
    final total = stats['total_ss'] ?? 0;
    final closed = stats['closed'] ?? 0;
    final open = stats['open'] ?? 0;
    final other = stats['other'] ?? 0;
    final breakdown = stats['breakdown'] as Map<String, dynamic>? ?? {};

    return Column(
      children: [
        Row(
          children: [
            _statCard('Total', total, Colors.blue),
            _statCard('Closed', closed, Colors.green),
            _statCard('Open', open, Colors.orange),
            _statCard('Other', other, Colors.grey),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _statCard('Open GL/SH', breakdown['open_gl_sh'] ?? 0, Colors.orangeAccent),
            _statCard('Open DH', breakdown['open_dh'] ?? 0, Colors.deepOrange),
            _statCard('Open PM', breakdown['open_pm'] ?? 0, Colors.redAccent),
          ],
        ),
      ],
    );
  }

  Widget _statCard(String label, int value, Color color) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Column(children: [
            FittedBox(child: Text('$value', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color))),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10)),
          ]),
        ),
      ),
    );
  }

  Widget _buildEiictmCard(Map<String, dynamic> data) {
    final total = data['total'] ?? 0;
    final have = data['have_ss'] ?? 0;
    final no = data['no_ss'] ?? 0;
    return Row(children: [
      _statCard('Total NRP', total, Colors.blue),
      _statCard('Punya SS', have, Colors.green),
      _statCard('Belum SS', no, Colors.red),
    ]);
  }

  Widget _buildBarChart(List<dynamic> daily) {
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
                Text('$day', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
              ],
            ),
          );
        },
      ),
    );
  }
}
