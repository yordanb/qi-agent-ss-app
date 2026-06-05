import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/manpower_coverage.dart';
import '../providers/manpower_provider.dart';

class ManpowerCoverageCard extends ConsumerWidget {
  final String nrp;
  final String? section;
  final int year;
  final int month;
  final bool compact;

  const ManpowerCoverageCard({
    super.key,
    required this.nrp,
    this.section,
    required this.year,
    required this.month,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(coverageSummaryProvider(year, month));

    return summaryAsync.when(
      data: (data) => _buildCard(context, ref, data),
      loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
      error: (e, _) => const SizedBox.shrink(), // silent fail
    );
  }

  Widget _buildCard(BuildContext context, WidgetRef ref, List<ManpowerCoverage> sections) {
    if (sections.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    if (compact) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...sections.map((s) => _sectionRow(context, s)),
          ],
        ),
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.groups, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Coverage SS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
              ],
            ),
            const SizedBox(height: 12),
            ...sections.map((s) => _sectionRow(context, s)),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () => _showCrewDetail(context, ref),
                icon: const Icon(Icons.visibility, size: 16),
                label: const Text('Lihat detail per Crew', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionRow(BuildContext context, ManpowerCoverage s) {
    final theme = Theme.of(context);
    final pct = s.coveragePct;
    final color = pct >= 80 ? Colors.green : (pct >= 50 ? Colors.orange : Colors.red);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.crew, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text('${s.totalSs}/${s.totalTarget} SS', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct / 100,
              minHeight: 12,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${s.totalPeople} orang', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              Text('${pct.toStringAsFixed(1)}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ],
      ),
    );
  }

  void _showCrewDetail(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _CrewDetailSheet(nrp: nrp, section: section, year: year, month: month),
    );
  }
}

class _CrewDetailSheet extends ConsumerWidget {
  final String nrp;
  final String? section;
  final int year;
  final int month;

  const _CrewDetailSheet({
    required this.nrp,
    required this.section,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crewAsync = ref.watch(crewCoverageProvider(section, year, month));

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (ctx, scrollController) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            Text('Coverage per Crew — $section', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Expanded(
              child: crewAsync.when(
                data: (crews) {
                  if (crews.isEmpty) {
                    return const Center(child: Text('Belum ada data crew'));
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: crews.length,
                    itemBuilder: (ctx, i) => _crewItem(context, crews[i]),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crewItem(BuildContext context, CrewCoverage c) {
    final theme = Theme.of(context);
    final pct = c.coveragePct;
    final color = pct >= 80 ? Colors.green : (pct >= 50 ? Colors.orange : Colors.red);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(c.crew, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${c.totalSs}/${c.targetSs} SS', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: pct / 100,
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${c.totalPeople} orang', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                Text('${pct.toStringAsFixed(1)}%', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
