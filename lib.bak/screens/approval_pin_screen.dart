import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApprovalPinScreen extends StatefulWidget {
  const ApprovalPinScreen({super.key});

  @override
  State<ApprovalPinScreen> createState() => _ApprovalPinScreenState();
}

class _ApprovalPinScreenState extends State<ApprovalPinScreen> {
  String? _pin;
  int _remaining = 0;
  bool _loading = true;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchPin();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchPin() async {
    setState(() { _loading = true; _error = null; });
    try {
      final data = await ApiService.getApprovalPin('');
      setState(() {
        _loading = false;
        _pin = data['pin'];
        _remaining = data['remaining_seconds'] ?? 60;
      });
      _startCountdown();
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining <= 1) {
        t.cancel();
        _fetchPin(); // auto-refresh
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval PIN'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _loading
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Memuat PIN...'),
                  ],
                )
              : _error != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 12),
                        Text(_error!, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _fetchPin,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Coba Lagi'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_user, size: 56, color: Colors.blueGrey),
                        const SizedBox(height: 16),
                        const Text('PIN Approval',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Masukkan PIN ini di halaman web',
                            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 24),

                        // PIN display
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blueGrey[200]!),
                          ),
                          child: Text(
                            _pin ?? '------',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 12,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Timer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              'Berlaku: ${_remaining}s',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('PIN berubah setiap 2 menit',
                            style: TextStyle(color: Colors.grey[500], fontSize: 11)),

                        const SizedBox(height: 24),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.amber, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Buka halaman upload web → masukkan PIN di atas → Approve',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
