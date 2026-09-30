import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/models/manpower_item.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

// State for manpower list
class ManpowerListState {
  final List<ManpowerItem> items;
  final bool loading;
  final String? error;
  final String? sectionFilter;

  const ManpowerListState({
    this.items = const [],
    this.loading = true,
    this.error,
    this.sectionFilter,
  });

  ManpowerListState copyWith({
    List<ManpowerItem>? items,
    bool? loading,
    String? error,
    String? sectionFilter,
  }) {
    return ManpowerListState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      sectionFilter: sectionFilter ?? this.sectionFilter,
    );
  }
}

// Notifier for manpower list (using Riverpod 2.x Notifier)
class ManpowerListNotifier extends Notifier<ManpowerListState> {
  @override
  ManpowerListState build() {
    return const ManpowerListState();
  }

  Future<void> load() async {
    state = state.copyWith(loading: true);
    try {
      final ds = ref.read(dioClientProvider);
      final dio = ds.dio;
      final params = <String, dynamic>{'page': 1, 'page_size': 500};
      if (state.sectionFilter != null) params['section'] = state.sectionFilter;
      final resp = await dio.get('/manpower', queryParameters: params);
      final data = resp.data as Map<String, dynamic>;
      final items = (data['data'] as List? ?? [])
          .map((e) => ManpowerItem.fromJson(e as Map<String, dynamic>))
          .toList();
      state = state.copyWith(items: items, loading: false, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> delete(ManpowerItem item) async {
    try {
      final ds = ref.read(dioClientProvider);
      await ds.dio.delete('/manpower/${item.id}');
      await load();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void setSectionFilter(String? section) {
    state = state.copyWith(sectionFilter: section);
    load();
  }
}

// Provider
final manpowerListProvider = NotifierProvider<ManpowerListNotifier, ManpowerListState>(ManpowerListNotifier.new);

class ManpowerListScreen extends ConsumerWidget {
  const ManpowerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manpowerListProvider);
    final notifier = ref.read(manpowerListProvider.notifier);
    final theme = Theme.of(context);
    final sections = state.items.map((e) => e.section).where((s) => s.isNotEmpty).toSet().toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Manpower'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          if (state.sectionFilter != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Hapus filter',
              onPressed: () => notifier.setSectionFilter(null),
            ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Manpower',
            onPressed: () async {
              final result = await context.push('/manpower-form');
              if (result == true) notifier.load();
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
                    selected: state.sectionFilter == null,
                    onSelected: (_) => notifier.setSectionFilter(null),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),
                  ...sections.map((s) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(s, style: const TextStyle(fontSize: 12)),
                          selected: state.sectionFilter == s,
                          onSelected: (_) => notifier.setSectionFilter(s),
                          visualDensity: VisualDensity.compact,
                        ),
                      )),
                ],
              ),
            ),
          ),
          // Table
          Expanded(
            child: state.loading
                ? const LoadingWidget(message: 'Memuat...')
                : state.error != null
                    ? Center(child: Column(children: [
                        Icon(Icons.error, color: Colors.red[300], size: 40),
                        const SizedBox(height: 8),
                        Text(state.error!),
                        ElevatedButton(onPressed: () => notifier.load(), child: const Text('Ulangi')),
                      ]))
                    : RefreshIndicator(
                        onRefresh: () => notifier.load(),
                        child: state.items.isEmpty
                            ? const Center(child: Text('Belum ada data manpower'))
                            : ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                itemCount: state.items.length,
                                separatorBuilder: (_, __) => const Divider(height: 1),
                                itemBuilder: (ctx, i) => _itemCard(context, ref, state.items[i], notifier),
                              ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _itemCard(BuildContext context, WidgetRef ref, ManpowerItem item, ManpowerListNotifier notifier) {
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
          if (result == true) notifier.load();
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
                  if (v == 'edit') {
                    context.push('/manpower-form', extra: item).then((r) {
                      if (r == true) notifier.load();
                    });
                  }
                  if (v == 'delete') _deleteConfirm(context, ref, item, notifier);
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

  Future<void> _deleteConfirm(BuildContext context, WidgetRef ref, ManpowerItem item, ManpowerListNotifier notifier) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus?'),
        content: Text('Hapus ${item.nama} (${item.nrp})?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await notifier.delete(item);
    }
  }

  Widget _badge(String text, Color color) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    );
  }
}
