import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nrpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _error;

  Future<void> _login() async {
    final nrp = _nrpController.text.trim();
    final password = _passwordController.text.trim();

    if (nrp.isEmpty) {
      setState(() => _error = 'Masukkan NRP');
      return;
    }
    if (password.isEmpty) {
      setState(() => _error = 'Masukkan password');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await ApiService.login(nrp, password);
      if (mounted) {
        // ApiService.login() already sets _authNrp, _isAdmin
        context.go('/dashboard', extra: {
          'nrp': nrp,
          'nama': result['nama'] ?? nrp,
          'is_admin': result['is_admin'] ?? false,
        });
      }
    } catch (e) {
      final errMsg = e.toString();
      String displayError;
      if (errMsg.contains('SocketException') ||
          errMsg.contains('Connection refused') ||
          errMsg.contains('No address')) {
        displayError =
            '❌ Server tidak terjangkau.\nCek browser: https://qi.mibt.my.id/health';
      } else if (errMsg.contains('404')) {
        displayError = '❌ NRP tidak ditemukan di database';
      } else if (errMsg.contains('401')) {
        displayError = '❌ Password salah';
      } else if (errMsg.contains('422')) {
        displayError = '❌ Format NRP salah';
      } else {
        displayError = '❌ $errMsg';
      }
      setState(() {
        _error = displayError;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield_outlined,
                    size: 48, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text('Quality Innovation',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text('Suggestion System & ESIC Tracking',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text('v3.4.1 • SPL2 & STYR',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500])),
              const SizedBox(height: 32),


              // NRP field
              SizedBox(
                width: 320,
                child: TextField(
                  controller: _nrpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NRP',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan NRP Anda',
                  ),
                  onSubmitted: (_) => _login(),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              SizedBox(
                width: 320,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Masukkan password',
                  ),
                  onSubmitted: (_) => _login(),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 320,
                child: Text(
                  'Default password: 12345',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic),
                ),
              ),

              const SizedBox(height: 16),

              // Error
              if (_error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(_error!,
                              style: const TextStyle(color: Colors.red))),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: 320,
                height: 48,
                child: FilledButton.icon(
                  onPressed: _isLoading ? null : _login,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.login),
                  label: Text(_isLoading ? 'Memeriksa...' : 'Masuk'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
