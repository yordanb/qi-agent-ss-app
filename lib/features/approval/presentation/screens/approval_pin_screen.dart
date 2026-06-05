import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

class ApprovalPinScreen extends ConsumerStatefulWidget {
  const ApprovalPinScreen({super.key});

  @override
  ConsumerState<ApprovalPinScreen> createState() => _ApprovalPinScreenState();
}

class _ApprovalPinScreenState extends ConsumerState<ApprovalPinScreen> {
  String? _pin;
  int _remainingSeconds = 0;
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
      final dio = Dio(BaseOptions(
        baseUrl: 'https://qi.mibt.my.id/api',
        headers: {'Accept': 'application/json'},
      ));
      final response = await dio.get(ApiConstants.pinGenerate);
      if (mounted) {
        setState(() {
          _pin = response.data['pin']?.toString();
          _remainingSeconds = response.data['remaining_seconds'] as int? ?? 120;
          _loading = false;
        });
        _startCountdown();
      }
    } catch (e) {
      if (mounted) setState(() { _loading = false; _error = e.toString(); });
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds <= 0) {
        t.cancel();
        if (mounted) setState(() { _pin = null; _error = 'PIN expired, generate ulang'; });
        return;
      }
      if (mounted) setState(() => _remainingSeconds--);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval PIN'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPin,
            tooltip: 'Generate PIN baru',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _loading
              ? const CircularProgressIndicator()
              : _error != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 12),
                        Text(_error!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _fetchPin,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Generate Ulang'),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_user, size: 48, color: Colors.blueGrey),
                        const SizedBox(height: 16),
                        const Text('PIN Approval', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Gunakan PIN ini untuk approval upload data', style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            if (_pin != null) {
                              Clipboard.setData(ClipboardData(text: _pin!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('PIN $_pin copied ke clipboard'), duration: const Duration(seconds: 2)),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blueGrey[300]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _pin ?? '------',
                                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 12, color: Colors.blueGrey),
                                ),
                                const SizedBox(height: 4),
                                const Text('Tap untuk copy', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.timer, size: 16, color: _remainingSeconds <= 30 ? Colors.red : Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Expired dalam $_remainingSeconds detik',
                              style: TextStyle(fontSize: 13, color: _remainingSeconds <= 30 ? Colors.red : Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _fetchPin,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Generate PIN Baru'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
