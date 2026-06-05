import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../domain/entities/snapshot.dart';
import '../providers/esic_provider.dart';

class EsicScreen extends ConsumerStatefulWidget {
  final String nrp;
  const EsicScreen({super.key, required this.nrp});

  @override
  ConsumerState<EsicScreen> createState() => _EsicScreenState();
}

class _EsicScreenState extends ConsumerState<EsicScreen> {
  @override
  Widget build(BuildContext context) {
    final esicAsync = ref.watch(esicNotifierProvider(widget.nrp));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ESIC TM'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(esicNotifierProvider(widget.nrp)),
          ),
        ],
      ),
      body: esicAsync.when(
        data: (snapshots) {
          if (snapshots.isEmpty) {
            return const EmptyWidget(message: 'Tidak ada data ESIC', icon: Icons.description_outlined);
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(esicNotifierProvider(widget.nrp)),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshots.length,
              itemBuilder: (context, i) => _buildItem(snapshots[i]),
            ),
          );
        },
        loading: () => const LoadingWidget(message: 'Memuat data ESIC...'),
        error: (e, _) => ErrorDisplayWidget(
          message: e.toString(),
          onRetry: () => ref.invalidate(esicNotifierProvider(widget.nrp)),
        ),
      ),
    );
  }

  Widget _buildItem(Snapshot snapshot) {
    final date = snapshot.snapshotDate ?? '-';
    final posisi = _extractPosisi(snapshot);
    final accCount = snapshot.accCount;
    final mtdCount = snapshot.mtdCount;
    final dokumenList = _extractDokumen(snapshot);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetail(snapshot),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: date + posisi
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.description, size: 20, color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        if (posisi.isNotEmpty)
                          Text(posisi, style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
              const SizedBox(height: 12),
              // Metrics row
              Row(
                children: [
                  _metricBadge(Icons.book, '$accCount', 'Diakses', Colors.green),
                  const SizedBox(width: 12),
                  _metricBadge(Icons.article, '$mtdCount', 'MTD', Colors.orange),
                  if (dokumenList.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    _metricBadge(Icons.insert_drive_file, '${dokumenList.length}', 'Dokumen', Colors.indigo),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricBadge(IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text('$value ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  String _extractPosisi(Snapshot s) {
    // posisi not in entity, try from nama/dept
    return '${s.nama ?? ''} • ${s.dept ?? ''}'.trim();
  }

  List<String> _extractDokumen(Snapshot s) {
    if (s.dokumenDiakses == null || s.dokumenDiakses!.isEmpty) return [];
    return s.dokumenDiakses!
        .split(RegExp(r'\.\s*'))
        .map((d) => d.trim())
        .where((d) => d.isNotEmpty)
        .toList();
  }

  void _showDetail(Snapshot snapshot) {
    final dokumenList = _extractDokumen(snapshot);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Text(snapshot.snapshotDate ?? '-', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${snapshot.nama ?? ''} • ${snapshot.dept ?? ''}', style: TextStyle(color: Colors.grey[600])),
              const Divider(height: 24),
              const Text('Dokumen Diakses', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              if (dokumenList.isEmpty)
                const Text('Tidak ada data', style: TextStyle(color: Colors.grey))
              else
                ...dokumenList.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.green[600]),
                      const SizedBox(width: 8),
                      Expanded(child: Text(d, style: const TextStyle(fontSize: 13))),
                    ],
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}
