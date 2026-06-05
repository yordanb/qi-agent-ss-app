import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/auth_repository.dart';
import '../providers/auth_provider.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String nrp;
  const ChangePasswordScreen({super.key, required this.nrp});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;
  String? _error;
  String? _success;

  Future<void> _change() async {
    if (_newController.text != _confirmController.text) {
      setState(() => _error = 'Password baru tidak cocok');
      return;
    }
    if (_newController.text.length < 5) {
      setState(() => _error = 'Password minimal 5 karakter');
      return;
    }
    setState(() { _loading = true; _error = null; _success = null; });
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.changePassword(widget.nrp, _oldController.text, _newController.text);
      if (mounted) setState(() { _loading = false; _success = 'Password berhasil diubah'; });
    } catch (e) {
      if (mounted) setState(() { _loading = false; _error = e.toString(); });
    }
  }

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _oldController, obscureText: true, decoration: const InputDecoration(labelText: 'Password Lama', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _newController, obscureText: true, decoration: const InputDecoration(labelText: 'Password Baru', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _confirmController, obscureText: true, decoration: const InputDecoration(labelText: 'Konfirmasi Password', border: OutlineInputBorder())),
            if (_error != null) ...[const SizedBox(height: 12), Text(_error!, style: const TextStyle(color: Colors.red))],
            if (_success != null) ...[const SizedBox(height: 12), Text(_success!, style: const TextStyle(color: Colors.green))],
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: _loading ? null : _change, child: _loading ? const CircularProgressIndicator() : const Text('Simpan'))),
          ],
        ),
      ),
    );
  }
}
