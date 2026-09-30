import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(userManagementNotifierProvider.notifier).loadUsers(),
    );
  }

  Future<void> _deleteUser(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus User?'),
        content: Text('Hapus user ${user.nrp}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final success = await ref
          .read(userManagementNotifierProvider.notifier)
          .deleteUser(user.nrp);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'User berhasil dihapus' : 'Gagal hapus user'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleStatus(User user) async {
    final success = await ref
        .read(userManagementNotifierProvider.notifier)
        .updateUser(nrp: user.nrp, isActive: !user.isActive);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Status user ${user.isActive ? 'dinonaktifkan' : 'diaktifkan'}'
                : 'Gagal update status',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _resetPassword(User user) async {
    final controller = TextEditingController();
    final newPassword = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password Baru',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (newPassword != null && newPassword.isNotEmpty && mounted) {
      final success = await ref
          .read(userManagementNotifierProvider.notifier)
          .resetPassword(nrp: user.nrp, newPassword: newPassword);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Password berhasil direset' : 'Gagal reset password'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userManagementNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen User'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah User',
            onPressed: () async {
              final result = await context.push('/users-form');
              if (result == true) {
                ref.read(userManagementNotifierProvider.notifier).loadUsers();
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(userManagementNotifierProvider.notifier).loadUsers(),
        child: state.isLoading
            ? const LoadingWidget(message: 'Memuat...')
            : state.error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(state.error!, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              ref.read(userManagementNotifierProvider.notifier).loadUsers(),
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  )
                : state.users.isEmpty
                    ? const Center(child: Text('Belum ada user'))
                    : ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.users.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return _userCard(user);
                        },
                      ),
      ),
    );
  }

  Widget _userCard(User user) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: user.role == 'admin' ? Colors.orange : Colors.blue,
          child: Text(
            user.nrp.substring(0, 2).toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          user.nrp,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            _badge(user.role.toUpperCase(), user.role == 'admin' ? Colors.orange : Colors.blue),
            const SizedBox(width: 8),
            _badge(
              user.isActive ? 'AKTIF' : 'NONAKTIF',
              user.isActive ? Colors.green : Colors.red,
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                context.push('/users-form', extra: user).then((result) {
                  if (result == true) {
                    ref.read(userManagementNotifierProvider.notifier).loadUsers();
                  }
                });
                break;
              case 'reset':
                _resetPassword(user);
                break;
              case 'toggle':
                _toggleStatus(user);
                break;
              case 'delete':
                _deleteUser(user);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'reset', child: Text('Reset Password')),
            PopupMenuItem(
              value: 'toggle',
              child: Text(user.isActive ? 'Nonaktifkan' : 'Aktifkan'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
