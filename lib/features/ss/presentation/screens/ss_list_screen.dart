import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../domain/entities/ss.dart';
import '../providers/ss_provider.dart';

class SsListScreen extends ConsumerStatefulWidget {
  final String nrp;
  const SsListScreen({super.key, required this.nrp});

  @override
  ConsumerState<SsListScreen> createState() => _SsListScreenState();
}

class _SsListScreenState extends ConsumerState<SsListScreen> {
  String _search = '';
  String _filter = 'semua';

  @override
  Widget build(BuildContext context) {
    final ssAsync = ref.watch(ssNotifierProvider(widget.nrp));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestion System'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(ssNotifierProvider(widget.nrp)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari judul SS...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => _search = ''),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              style: const TextStyle(fontSize: 14),
              onChanged: (v) => setState(() => _search = v.toLowerCase()),
            ),
          ),
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('Semua', 'semua'),
                const SizedBox(width: 8),
                _buildFilterChip('Approved', 'approved'),
                const SizedBox(width: 8),
                _buildFilterChip('Waiting', 'waiting'),
                const SizedBox(width: 8),
                _buildFilterChip('Other', 'other'),
              ],
            ),
          ),
          // List
          Expanded(
            child: ssAsync.when(
              data: (page) {
                var items = page.items;
                if (_filter != 'semua') {
                  items = items.where((s) => s.statusCategory == _filter).toList();
                }
                if (_search.isNotEmpty) {
                  items = items.where((s) => s.judul.toLowerCase().contains(_search)).toList();
                }
                if (items.isEmpty) {
                  return const EmptyWidget(message: 'Tidak ada data SS', icon: Icons.lightbulb_outline);
                }
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(ssNotifierProvider(widget.nrp)),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _buildItem(items[i]),
                  ),
                );
              },
              loading: () => const LoadingWidget(message: 'Memuat data SS...'),
              error: (e, _) => ErrorDisplayWidget(
                message: e.toString(),
                onRetry: () => ref.invalidate(ssNotifierProvider(widget.nrp)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final selected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.normal, color: selected ? Colors.white : Theme.of(context).colorScheme.primary),
          ),
        ),
    );
  }

  Widget _buildItem(Ss record) {
    final status = (record.currentStatus ?? '').toString().toUpperCase();
    final color = record.statusCategory == 'approved'
        ? Colors.green
        : record.statusCategory == 'waiting'
            ? Colors.indigo
            : Colors.orange;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: icon + judul
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.lightbulb, size: 20, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(record.judul, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        if (record.noSs.isNotEmpty)
                          Text(record.noSs, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                        const SizedBox(height: 4),
                        // Status badge below title
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                          child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color, letterSpacing: 0.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Bottom row: date + grade + reward
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 12, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(record.tanggalLaporan ?? '-', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  const Spacer(),
                  if (record.nama != null) ...[
                    Icon(Icons.person, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(record.nama!, style: TextStyle(fontSize: 11, color: Colors.grey[500]), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
