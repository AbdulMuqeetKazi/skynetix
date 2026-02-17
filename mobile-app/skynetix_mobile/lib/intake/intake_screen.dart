import 'dart:async';
import 'package:flutter/material.dart';
import '../offline/connectivity_service.dart';
import 'intake_controller.dart';
import 'intake_state.dart';
import 'intake_fallback.dart';

class IntakeScreen extends StatefulWidget {
  const IntakeScreen({super.key});

  @override
  State<IntakeScreen> createState() => _IntakeScreenState();
}

class _IntakeScreenState extends State<IntakeScreen>
    with WidgetsBindingObserver {
  final IntakeController _controller = IntakeController();
  final TextEditingController _textController = TextEditingController();

  StreamSubscription<bool>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _connectivitySub =
        ConnectivityService().isOnline.listen((isOnline) {
      if (!isOnline && mounted) {
        IntakeFallback.toOffline(context);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySub?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ConnectivityService().isOnline.first.then((isOnline) {
        if (!isOnline && mounted) {
          IntakeFallback.toOffline(context);
        }
      });
    }
  }

  void _refresh() {
    if (_controller.state == IntakeState.error && mounted) {
      IntakeFallback.toOffline(context);
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Intake'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _StateIndicator(state: _controller.state),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Describe the emergency',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            if (_controller.state == IntakeState.idle)
              ElevatedButton(
                onPressed: () {
                  _controller.startRecording();
                  _refresh();
                },
                child: const Text('Start Voice Input'),
              ),

            if (_controller.state == IntakeState.recording)
              ElevatedButton(
                onPressed: () {
                  _controller.stopRecording();
                  _refresh();
                },
                child: const Text('Stop Recording'),
              ),

            if (_controller.state == IntakeState.processing)
              ElevatedButton(
                onPressed: () {
                  _controller.complete(_textController.text);
                  _refresh();
                },
                child: const Text('Submit Emergency'),
              ),

            if (_controller.state == IntakeState.completed)
              Column(
                children: [
                  const Text(
                    'Emergency received successfully.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _controller.reset();
                      _textController.clear();
                      _refresh();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StateIndicator extends StatelessWidget {
  final IntakeState state;

  const _StateIndicator({required this.state});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Current state: ${state.name.toUpperCase()}',
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}