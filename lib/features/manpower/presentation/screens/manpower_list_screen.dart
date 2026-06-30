import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/providers/login_provider.dart';
import '../../data/models/manpower_item.dart';
import '../../data/datasource/manpower_cud_datasource.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ManpowerListScreen extends ConsumerStatefulWidget {
  const ManpowerListScreen({super.key});

  @override
  ConsumerState<ManpowerListScreen> createState() => _ManpowerListScreenState();
}

class _ManpowerListScreenState extends ConsumerState<ManpowerListScreen> {
  List<ManpowerItem> _items = [];
  bool _loading = true;
  String? _error;
  String? _sectionFilter;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final ds = ref.read(dioClientProvider);
      final dio = ds.dio;
      final params = <String, dynamic>{'page': 1, 'page_size': 500};
      if (_sectionFilter != null) params['section'] = _sectionFilter;
      final resp = await dio.get('/manpower', queryParameters: params);
      final data = resp.data as Map<String, dynamic>;
      _items = (data['data'] as List? ?? [])
          .map((e) => ManpowerItem.fromJson(e as Map<String, dynamic>))
          .toList();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _deleteConfirm(ManpowerItem item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus?'),
        content: Text('Hapus ${item.nama} (${item.nrp})?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), style: FilledButton.styleFrom(backgroundColor: Colors.red), child: const Text('Hapus')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      final ds = ref.read(dioClientProvider);
      await ds.dio.delete('/manpower/${item.id}');
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal hapus: $e'), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = _items.map((e) => e.section).where((s) => s.isNotEmpty).toSet().toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Manpower'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_sectionFilter != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Hapus filter',
              onPressed: () {
                setState(() => _sectionFilter = null);
                _load();
              },
            ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Manpower',
            onPressed: () async {
              final result = await context.push('/manpower-form');
              if (result == true) _load();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Section filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ChoiceChip(
                    label: const Text('Semua', style: TextStyle(fontSize: 12)),
                    selected: _sectionFilter == null,
                    onSelected: (_) => setState(() { _sectionFilter = null; _load(); }),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),
                  ...sections.map((s) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(s, style: const TextStyle(fontSize: 12)),
                      selected: _sectionFilter == s,
                      onSelected: (_) => setState(() { _sectionFilter = s; _load(); }),
                      visualDensity: VisualDensity.compact,
                    ),
                  )),
                ],
              ),
            ),
          ),
          // Table
          Expanded(
            child: _loading
                ? const LoadingWidget(message: 'Memuat...')
                : _error != null
                    ? Center(child: Column(children: [Icon(Icons.error, color: Colors.red[300], size: 40), const SizedBox(height: 8), Text(_error!), ElevatedButton(onPressed: _load, child: const Text('Ulangi'))]))
                    : RefreshIndicator(
                        onRefresh: _load,
                        child: _items.isEmpty
                            ? const Center(child: Text('Belum ada data manpower'))
                            : ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                itemCount: _items.length,
                                separatorBuilder: (_, __) => const Divider(height: 1),
                                itemBuilder: (ctx, i) => _itemCard(_items[i]),
                              ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _itemCard(ManpowerItem item) {
    final theme = Theme.of(context);
    final isNotActive = !item.isActive;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isNotActive ? Colors.grey[100] : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final result = await context.push('/manpower-form', extra: item);
          if (result == true) _load();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
                        _badge(item.status, item.status == 'Aktif' ? Colors.green : Colors.red),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text('NRP: ${item.nrp}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _badge(item.section, theme.colorScheme.primary),
                        _badge(item.crew, Colors.indigo),
                        _badge(item.posisi, Colors.teal),
                        if (item.targetSs > 0) _badge('Target: ${item.targetSs} SS', Colors.orange),
                        if (!item.isActive) _badge('Tidak Aktif', Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'edit') context.push('/manpower-form', extra: item).then((r) { if (r == true) _load(); });
                  if (v == 'delete') _deleteConfirm(item);
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Edit')])),
                  const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red, size: 18), SizedBox(width: 8), Text('Hapus', style: TextStyle(color: Colors.red))])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    );
  }
}
