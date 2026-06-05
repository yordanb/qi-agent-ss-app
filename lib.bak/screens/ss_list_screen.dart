import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SsListScreen extends StatefulWidget {
  final String nrp;
  const SsListScreen({super.key, required this.nrp});

  @override
  State<SsListScreen> createState() => _SsListScreenState();
}

class _SsListScreenState extends State<SsListScreen> {
  List<dynamic> _records = [];
  bool _loading = true;
  String? _error;
  int _page = 1;
  bool _hasMore = true;
  final _scrollController = ScrollController();
  String _filterSource = 'all';

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadData({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
    }
    try {
      final data = await ApiService.getSsByNrp(widget.nrp,
          page: _page, pageSize: 20);
      final records = data['data'] as List<dynamic>? ?? [];
      final total = data['total'] as int? ?? 0;
      if (mounted) {
        setState(() {
          if (reset) {
            _records = records;
          } else {
            _records.addAll(records);
          }
          _hasMore = _records.length < total;
          _loading = false;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    _page++;
    await _loadData();
  }

  /// Kategorikan status SS
  /// - 'closed'    → sudah dinilai, ada grade
  /// - 'waiting'   → menunggu penilaian/approval
  /// - 'other'     → sisanya (revisi, input, upload)
  String _statusCategory(Map<String, dynamic> r) {
    if (r['source'] == 'closed') return 'closed';
    final status = (r['current_status'] ?? '').toString();
    if (status.toLowerCase().contains('menunggu')) return 'waiting';
    return 'other';
  }

  Color _statusColor(Map<String, dynamic> r) {
    final cat = _statusCategory(r);
    if (cat == 'closed') return Colors.green;
    if (cat == 'waiting') return Colors.indigo;
    return Colors.orange;
  }

  Color _statusBgColor(Map<String, dynamic> r) {
    final cat = _statusCategory(r);
    if (cat == 'closed') return Colors.green[50]!;
    if (cat == 'waiting') return Colors.indigo[50]!;
    return Colors.orange[50]!;
  }

  List<dynamic> get _filtered {
    if (_filterSource == 'all') return _records;
    return _records.where((r) => _statusCategory(r) == _filterSource).toList();
  }

  int get _countClosed => _records.where((r) => _statusCategory(r) == 'closed').length;
  int get _countWaiting => _records.where((r) => _statusCategory(r) == 'waiting').length;
  int get _countOther => _records.where((r) => _statusCategory(r) == 'other').length;

  @override
  Widget build(BuildContext context) {
    if (_loading && _records.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && _records.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
                onPressed: () => _loadData(reset: true),
                child: const Text('Coba Lagi')),
          ],
        ),
      );
    }

    final filtered = _filtered;

    return Column(
      children: [
        // Summary bar
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(
            children: [
              _filterChip('Semua ($_countClosed+$_countWaiting+$_countOther)', 'all', null),
              const Spacer(),
            ],
          ),
        ),
        // Filter chips
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
          child: Row(
            children: [
              _filterChip('Approved ($_countClosed)', 'closed', Colors.green),
              const SizedBox(width: 6),
              _filterChip('Wait Approval ($_countWaiting)', 'waiting', Colors.indigo),
              const SizedBox(width: 6),
              _filterChip('Lainnya ($_countOther)', 'other', Colors.orange),
            ],
          ),
        ),

        // List
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 48, color: Colors.grey[300]),
                      const SizedBox(height: 8),
                      Text('Tidak ada data',
                          style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: filtered.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (i >= filtered.length) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ));
                    }
                    return _buildItem(filtered[i]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, String value, Color? color) {
    final selected = _filterSource == value;
    return FilterChip(
      label: Text(label, style: TextStyle(fontSize: 12)),
      selected: selected,
      selectedColor: color?.withAlpha(40),
      checkmarkColor: color,
      onSelected: (_) => setState(() => _filterSource = value),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildItem(Map<String, dynamic> r) {
    final cat = _statusCategory(r);
    final color = _statusColor(r);
    final bgColor = _statusBgColor(r);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withAlpha(30), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetail(r),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status icon
              CircleAvatar(
                radius: 20,
                backgroundColor: bgColor,
                child: Icon(
                  cat == 'closed'
                      ? Icons.check_circle
                      : cat == 'waiting'
                          ? Icons.hourglass_top
                          : Icons.pending,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['judul'] ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(
                        '${r['tanggal_laporan'] ?? '-'} • ${r['dept'] ?? '-'}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Status chip — like closed chip but for all categories
              cat == 'closed'
                  ? Chip(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      label: Text(
                          '${r['grade_ss'] ?? '-'} • ${r['kualitas_ss'] ?? '-'}',
                          style: const TextStyle(fontSize: 11)),
                      backgroundColor: bgColor,
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  : Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _shortStatus(r['current_status'] ?? 'Pending'),
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortStatus(String status) {
    if (status.contains('Dept Head')) return 'Wait Dept Head';
    if (status.contains('SH / GL')) return 'Wait SH/GL';
    if (status.contains('PM')) return 'Wait PM';
    if (status.contains('Revisi') || status.contains('revisi')) return 'Revisi';
    if (status.contains('Upload FSFI')) return 'Upload FSFI';
    if (status.contains('Input Penilaian')) return 'Input Nilai';
    return status.length > 15 ? '${status.substring(0, 15)}..' : status;
  }

  void _showDetail(Map<String, dynamic> r) {
    final cat = _statusCategory(r);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusBgColor(r),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  cat == 'closed'
                      ? '✅ Approved'
                      : cat == 'waiting'
                          ? '⏳ ${r['current_status'] ?? 'Wait Approval'}'
                          : '📋 ${r['current_status'] ?? 'Pending'}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: _statusColor(r)),
                ),
              ),
              const SizedBox(height: 16),
              Text(r['judul'] ?? '-',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _detailRow('No SS', r['no_ss']),
              _detailRow('Tanggal Laporan', r['tanggal_laporan']),
              _detailRow('Dept', r['dept']),
              _detailRow('Divisi', r['divisi']),
              _detailRow('Distrik', r['distrik']),
              if (cat == 'closed') ...[
                const Divider(),
                _detailRow('Grade', r['grade_ss']),
                _detailRow('Kualitas', r['kualitas_ss']),
                _detailRow('Kategori', r['kategori_ss']),
                _detailRow('Reward', 'Rp ${r['reward_ss'] ?? 0}'),
                _detailRow('Dinilai Oleh', r['dinilai_oleh']),
                _detailRow('Tanggal Menilai', r['tanggal_menilai']),
              ] else ...[
                const Divider(),
                _detailRow('Status Saat Ini', r['current_status']),
                _detailRow('No SS', r['no_ss']),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 130,
              child: Text(label,
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.w500))),
          Expanded(child: Text(value?.toString() ?? '-')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
