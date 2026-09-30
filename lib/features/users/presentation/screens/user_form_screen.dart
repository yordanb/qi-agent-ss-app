import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nrpController;
  late TextEditingController _passwordController;
  String _role = 'user';
  bool _isActive = true;
  bool _saving = false;

  bool get _isEdit => widget.user != null;

  @override
  void initState() {
    super.initState();
    _nrpController = TextEditingController(text: widget.user?.nrp ?? '');
    _passwordController = TextEditingController();
    _role = widget.user?.role ?? 'user';
    _isActive = widget.user?.isActive ?? true;
  }

  @override
  void dispose() {
    _nrpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final notifier = ref.read(userManagementNotifierProvider.notifier);
    bool success;

    if (_isEdit) {
      success = await notifier.updateUser(
        nrp: _nrpController.text.trim(),
        role: _role,
        isActive: _isActive,
      );
    } else {
      success = await notifier.createUser(
        nrp: _nrpController.text.trim(),
        password: _passwordController.text,
        role: _role,
      );
    }

    if (mounted) {
      setState(() => _saving = false);
      if (success) {
        context.pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ref.read(userManagementNotifierProvider).error ?? 'Gagal simpan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit User' : 'Tambah User'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // NRP
              TextFormField(
                controller: _nrpController,
                enabled: !_isEdit,
                decoration: const InputDecoration(
                  labelText: 'NRP *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (!_isEdit && (v == null || v.trim().isEmpty)) {
                    return 'NRP wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password (only for new user)
              if (!_isEdit) ...[
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (v) {
                    if (v == null || v.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Role
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.admin_panel_settings),
                ),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('User')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (v) => setState(() => _role = v ?? 'user'),
              ),
              const SizedBox(height: 16),

              // Status
              SwitchListTile(
                title: const Text('Aktif'),
                subtitle: Text(_isActive ? 'User bisa login' : 'User tidak bisa login'),
                value: _isActive,
                onChanged: (v) => setState(() => _isActive = v),
              ),
              const SizedBox(height: 24),

              // Save button
              SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(_isEdit ? 'Simpan Perubahan' : 'Tambah User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
