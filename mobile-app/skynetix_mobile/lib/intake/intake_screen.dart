import 'package:flutter/material.dart';

import 'intake_controller.dart';
import 'intake_state.dart';

class IntakeScreen extends StatefulWidget {
  const IntakeScreen({super.key});

  @override
  State<IntakeScreen> createState() => _IntakeScreenState();
}

class _IntakeScreenState extends State<IntakeScreen> {
  final IntakeController _controller = IntakeController();
  final TextEditingController _textController = TextEditingController();

  void _refresh() {
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
                  _controller.complete();
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

            if (_controller.state == IntakeState.error)
              Column(
                children: [
                  const Text(
                    'Something went wrong.',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _controller.reset();
                      _refresh();
                    },
                    child: const Text('Retry'),
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
