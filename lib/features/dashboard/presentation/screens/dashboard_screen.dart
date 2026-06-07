import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../auth/presentation/providers/login_provider.dart';
import '../../../manpower/presentation/widgets/manpower_coverage_card.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final String nrp;
  final String nama;
  final bool isAdmin;

  const DashboardScreen({
    super.key,
    this.nrp = '',
    this.nama = '',
    this.isAdmin = false,
  });

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  final List<Map<String, dynamic>> _months = [];
  String _effectiveNrp = '';

  @override
  void initState() {
    super.initState();
    _initMonths();
    _effectiveNrp = widget.nrp;
  }

  void _initMonths() {
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

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    final nrp = _effectiveNrp.isNotEmpty
        ? _effectiveNrp
        : (loginState.value?.nrp ?? widget.nrp);

    final dashboardAsync = nrp.isNotEmpty
        ? ref.watch(dashboardNotifierProvider(nrp))
        : const AsyncValue<DashboardStats?>.data(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quality Innovation'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (nrp.isNotEmpty) ref.invalidate(dashboardNotifierProvider(nrp));
            },
          ),
          if (widget.isAdmin)
            IconButton(
              icon: const Icon(Icons.verified_user),
              tooltip: 'Approval PIN',
              onPressed: () => context.push('/approval-pin'),
            ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Dashboard Departemen',
            onPressed: () => context.push('/dept-dashboard'),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'manpower') {
                context.push('/manpower');
              } else if (value == 'theme') {
                context.push('/theme-settings');
              } else if (value == 'change_password') {
                context.push('/change-password', extra: {'nrp': nrp});
              } else if (value == 'logout') {
                ref.read(loginNotifierProvider.notifier).logout();
                context.go('/login');
              }
            },
            itemBuilder: (context) => [
              if (widget.isAdmin)
                const PopupMenuItem(value: 'manpower', child: Row(children: [Icon(Icons.group, size: 20), SizedBox(width: 8), Text('Manajemen Manpower')])),
              const PopupMenuItem(value: 'theme', child: Row(children: [Icon(Icons.palette, size: 20), SizedBox(width: 8), Text('Pilih Tema')])),
              const PopupMenuItem(value: 'change_password', child: Row(children: [Icon(Icons.key, size: 20), SizedBox(width: 8), Text('Ganti Password')])),
              const PopupMenuItem(value: 'logout', child: Row(children: [Icon(Icons.logout, size: 20), SizedBox(width: 8), Text('Logout')])),
            ],
          ),
        ],
      ),
      body: dashboardAsync.when(
        data: (stats) => _buildDashboardContent(stats, nrp),
        loading: () => const LoadingWidget(message: 'Memuat data...'),
        error: (e, _) => ErrorDisplayWidget(message: e.toString(), onRetry: () {
          if (nrp.isNotEmpty) ref.invalidate(dashboardNotifierProvider(nrp));
        }),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) {
          if (i == 1) {
            context.push('/ss', extra: {'nrp': nrp});
          } else if (i == 2) {
            context.push('/esic', extra: {'nrp': nrp});
          } else {
            setState(() => _selectedIndex = i);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'SS'),
          NavigationDestination(icon: Icon(Icons.description), label: 'ESIC'),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(DashboardStats? stats, String nrp) {
    final nama = (widget.nama.isNotEmpty ? widget.nama : (stats?.nama ?? '-'));
    final dept = stats?.dept ?? '-';
    final lastUpdate = _formatLastUpdate(stats?.lastUpdate ?? '-');

    return RefreshIndicator(
      onRefresh: () async {
        if (nrp.isNotEmpty) ref.invalidate(dashboardNotifierProvider(nrp));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card - gradient background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: widget.isAdmin
                        ? const Icon(Icons.admin_panel_settings, size: 32, color: Colors.white)
                        : const Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('NRP: $nrp', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                        Text('Dept: $dept', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                        const SizedBox(height: 4),
                        Row(children: [
                          Icon(Icons.update, size: 12, color: Colors.white.withOpacity(0.6)),
                          const SizedBox(width: 4),
                          Text('Update: $lastUpdate', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Monthly Stats - bigger numbers
            _buildMonthlyStatsSection(nrp),
            const SizedBox(height: 12),

            // Month picker
            _buildMonthPicker(),
            const SizedBox(height: 24),

            // ESIC Summary
            const Text('ESIC TM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.description, color: Colors.grey),
                ),
                title: const Text('ESIC TM', style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Buka tab ESIC untuk detail'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  final loginState = ref.read(loginNotifierProvider);
                  final nrp = _effectiveNrp.isNotEmpty ? _effectiveNrp : (loginState.value?.nrp ?? widget.nrp);
                  context.push('/esic', extra: {'nrp': nrp});
                },
              ),
            ),
            const SizedBox(height: 16),

            // Coverage SS Card (admin only, collapsible)
            if (widget.isAdmin)
              _buildCoverageExpansion(nrp, dept),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyStatsSection(String nrp) {
    if (nrp.isEmpty) {
      return const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('NRP tidak tersedia')));
    }
    final monthlyAsync = ref.watch(
      _monthlyStatsFutureProvider((nrp: nrp, year: _selectedMonth.year, month: _selectedMonth.month)),
    );

    return monthlyAsync.when(
      data: (monthly) {
        final total = monthly.total;
        final approved = monthly.approved;
        final waiting = monthly.waiting;
        final other = monthly.other;
        final monthLabel = DateFormat('MMMM yyyy').format(_selectedMonth);
        final isFutureMonth = _selectedMonth.isAfter(DateTime(DateTime.now().year, DateTime.now().month));
        final hasData = total > 0 || approved > 0 || waiting > 0 || other > 0;

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                if (isFutureMonth && !hasData) ...[
                  Icon(Icons.info_outline, size: 32, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 8),
                  Text('Belum ada data', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                  Text(monthLabel, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                ] else ...[
                  Row(
                    children: [
                      _iconStat(Icons.assignment, 'Total', total, Theme.of(context).colorScheme.primary),
                      _iconStat(Icons.check_circle, 'Approved', approved, Colors.green),
                      _iconStat(Icons.hourglass_top, 'Waiting', waiting, Colors.indigo),
                      _iconStat(Icons.pending, 'Other', other, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(monthLabel, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildMonthPicker() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _months.length,
        itemBuilder: (context, i) {
          final m = _months[i];
          final isSelected = m['year'] == _selectedMonth.year && m['month'] == _selectedMonth.month;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(m['label'], style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary)),
              selected: isSelected,
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onSelected: (_) => setState(() => _selectedMonth = DateTime(m['year'], m['month'], 1)),
              visualDensity: VisualDensity.compact,
            ),
          );
        },
      ),
    );
  }

  Widget _iconStat(IconData icon, String label, int value, Color color) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(height: 8),
          Text('$value', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCoverageExpansion(String nrp, String dept) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(Icons.groups, color: theme.colorScheme.primary),
        title: const Text('Coverage SS', style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: const Text('Klik untuk detail per section/crew'),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ManpowerCoverageCard(
            nrp: nrp,
            section: dept,
            year: _selectedMonth.year,
            month: _selectedMonth.month,
            compact: true,
          ),
        ],
      ),
    );
  }
}

String _formatLastUpdate(String raw) {
  if (raw == '-') return raw;
  try {
    final dt = DateTime.parse(raw).toLocal();
    return DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(dt);
  } catch (_) {
    return raw;
  }
}

final _monthlyStatsFutureProvider = FutureProvider.family<MonthlyStats, ({String nrp, int year, int month})>((ref, params) async {
  final repo = ref.read(dashboardRepositoryProvider);
  return repo.getMonthlyStats(params.nrp, params.year, params.month);
});
