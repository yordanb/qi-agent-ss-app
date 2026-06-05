import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/models/manpower_item.dart';

class ManpowerFormScreen extends ConsumerStatefulWidget {
  final ManpowerItem? item;

  const ManpowerFormScreen({super.key, this.item});

  @override
  ConsumerState<ManpowerFormScreen> createState() => _ManpowerFormScreenState();
}

class _ManpowerFormScreenState extends ConsumerState<ManpowerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nrpCtrl;
  late TextEditingController _namaCtrl;
  late TextEditingController _sectionCtrl;
  late TextEditingController _crewCtrl;
  late TextEditingController _posisiCtrl;
  late TextEditingController _jabatanCtrl;
  late TextEditingController _targetCtrl;
  String _status = 'Aktif';
  bool _saving = false;

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nrpCtrl = TextEditingController(text: item?.nrp ?? '');
    _namaCtrl = TextEditingController(text: item?.nama ?? '');
    _sectionCtrl = TextEditingController(text: item?.section ?? '');
    _crewCtrl = TextEditingController(text: item?.crew ?? '');
    _posisiCtrl = TextEditingController(text: item?.posisi ?? '');
    _jabatanCtrl = TextEditingController(text: item?.jabatan ?? '');
    _targetCtrl = TextEditingController(text: (item?.targetSs ?? 2).toString());
    _status = item?.status ?? 'Aktif';
  }

  @override
  void dispose() {
    _nrpCtrl.dispose();
    _namaCtrl.dispose();
    _sectionCtrl.dispose();
    _crewCtrl.dispose();
    _posisiCtrl.dispose();
    _jabatanCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _formData() {
    return {
      'nrp': _nrpCtrl.text.trim(),
      'nama': _namaCtrl.text.trim(),
      'section': _sectionCtrl.text.trim(),
      'crew': _crewCtrl.text.trim(),
      'posisi': _posisiCtrl.text.trim(),
      'jabatan': _jabatanCtrl.text.trim(),
      'target_ss': int.tryParse(_targetCtrl.text) ?? 2,
      'status': _status,
    };
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final dio = ref.read(dioClientProvider).dio;
      final data = _formData();
      if (_isEdit) {
        await dio.put('/manpower/${widget.item!.id}', data: data);
      } else {
        await dio.post('/manpower/single', data: data);
      }
      if (mounted) context.pop(true);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: $e'), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Manpower' : 'Tambah Manpower'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nrpCtrl, 'NRP *', keyboardType: TextInputType.number),
              _field(_namaCtrl, 'Nama *'),
              _field(_sectionCtrl, 'Section *'),
              _field(_crewCtrl, 'Crew *'),
              _field(_posisiCtrl, 'Posisi'),
              _field(_jabatanCtrl, 'Jabatan'),
              _field(_targetCtrl, 'Target SS', keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              // Status dropdown
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: const [
                  DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                  DropdownMenuItem(value: 'Cuti', child: Text('Cuti')),
                  DropdownMenuItem(value: 'Pindah', child: Text('Pindah')),
                  DropdownMenuItem(value: 'Non-aktif', child: Text('Non-aktif')),
                ],
                onChanged: (v) => setState(() => _status = v ?? 'Aktif'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(_isEdit ? 'Simpan Perubahan' : 'Tambah'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        validator: (v) {
          if (label.endsWith('*') && (v == null || v.trim().isEmpty)) return 'Wajib diisi';
          return null;
        },
      ),
    );
  }
}
