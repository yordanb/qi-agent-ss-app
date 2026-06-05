import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EsicScreen extends StatefulWidget {
  final String nrp;
  final List<dynamic> snapshots;
  final bool isLoading;

  const EsicScreen({
    super.key,
    required this.nrp,
    required this.snapshots,
    required this.isLoading,
  });

  @override
  State<EsicScreen> createState() => _EsicScreenState();
}

class _EsicScreenState extends State<EsicScreen> {
  Map<String, dynamic>? _compareResult;
  Map<String, dynamic>? _progressResult;
  bool _loadingCompare = false;

  Future<void> _compareSnapshots() async {
    if (widget.snapshots.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Butuh minimal 2 snapshot')));
      return;
    }

    // Pick first and last snapshot dates
    final first = widget.snapshots.last; // oldest
    final last = widget.snapshots.first; // newest

    setState(() => _loadingCompare = true);

    try {
      final result = await ApiService.compareEsic(
        widget.nrp,
        first['snapshot_date'],
        last['snapshot_date'],
      );
      if (mounted) {
        setState(() {
          _compareResult = result;
          _loadingCompare = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingCompare = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _checkProgress() async {
    if (widget.snapshots.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Butuh minimal 2 snapshot')));
      return;
    }

    final first = widget.snapshots.last;
    final last = widget.snapshots.first;

    setState(() => _loadingCompare = true);

    try {
      final result = await ApiService.checkProgress(
        widget.nrp,
        first['snapshot_date'],
        last['snapshot_date'],
      );
      if (mounted) {
        setState(() {
          _progressResult = result;
          _loadingCompare = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingCompare = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.snapshots.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('Belum ada data ESIC'),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action buttons
          Row(
            children: [
              FilledButton.icon(
                onPressed: _loadingCompare ? null : _compareSnapshots,
                icon: const Icon(Icons.compare_arrows),
                label: const Text('Compare'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _loadingCompare ? null : _checkProgress,
                icon: const Icon(Icons.trending_up),
                label: const Text('Progress'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Compare / Progress result
          if (_compareResult != null) _buildCompareResult(),
          if (_progressResult != null) _buildProgressResult(),

          const SizedBox(height: 16),

          // Snapshots list
          Text('Snapshots (${widget.snapshots.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          ...widget.snapshots.map((s) {
            final date = s['snapshot_date'] ?? '-';
            final accDocs = (s['dokumen_diakses'] ?? '')
                .toString()
                .split('\n')
                .where((d) => d.trim().isNotEmpty)
                .toList();
            final mtdDocs = (s['dokumen_mtd'] ?? '')
                .toString()
                .split('\n')
                .where((d) => d.trim().isNotEmpty)
                .toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ExpansionTile(
                title: Text('Snapshot $date'),
                subtitle: Text(
                    '${accDocs.length} diakses, ${mtdDocs.length} MTD'),
                children: [
                  if (accDocs.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Dokumen Diakses:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...accDocs.map((d) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 2),
                          child: Text('• $d',
                              style: const TextStyle(fontSize: 13)),
                        )),
                  ],
                  if (mtdDocs.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Dokumen MTD:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...mtdDocs.map((d) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 2),
                          child: Text('• $d',
                              style: const TextStyle(fontSize: 13)),
                        )),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCompareResult() {
    final r = _compareResult!;
    final newAcc = r['new_dokumen_diakses'] as List<dynamic>? ?? [];
    final newMtd = r['new_dokumen_mtd'] as List<dynamic>? ?? [];
    final totalNew = r['total_new'] ?? 0;

    return Card(
      color: totalNew > 0 ? Colors.green[50] : Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(totalNew > 0 ? Icons.trending_up : Icons.trending_flat,
                    color: totalNew > 0 ? Colors.green : Colors.orange),
                const SizedBox(width: 8),
                Text('Compare: ${r['from_date']} → ${r['to_date']}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text('$totalNew judul baru'),
            if (newAcc.isNotEmpty) ...[
              const SizedBox(height: 4),
              const Text('Diakses:', style: TextStyle(fontWeight: FontWeight.w500)),
              ...newAcc.map((d) => Text('• $d', style: const TextStyle(fontSize: 13))),
            ],
            if (newMtd.isNotEmpty) ...[
              const SizedBox(height: 4),
              const Text('MTD:', style: TextStyle(fontWeight: FontWeight.w500)),
              ...newMtd.map((d) => Text('• $d', style: const TextStyle(fontSize: 13))),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressResult() {
    final r = _progressResult!;
    final stagnant = r['stagnant'] as bool? ?? true;
    final newDocs = r['new_documents'] as List<dynamic>? ?? [];

    return Card(
      color: stagnant ? Colors.red[50] : Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(stagnant ? Icons.warning : Icons.check_circle,
                    color: stagnant ? Colors.red : Colors.green),
                const SizedBox(width: 8),
                Text(r['status'] ?? '-',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: stagnant ? Colors.red : Colors.green)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Baseline: ${r['baseline_count']} dokumen'),
            Text('Latest: ${r['latest_count']} dokumen'),
            Text('Baru: ${r['new_count']} dokumen'),
            if (newDocs.isNotEmpty) ...[
              const SizedBox(height: 4),
              ...newDocs.map((d) => Text('• $d', style: const TextStyle(fontSize: 13))),
            ],
          ],
        ),
      ),
    );
  }
}
