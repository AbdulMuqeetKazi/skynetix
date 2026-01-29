import 'package:flutter/material.dart';

class EmergencyNumber {
  final String label;
  final String number;

  const EmergencyNumber(this.label, this.number);
}

class OfflineEmergencyScreen extends StatelessWidget {
  const OfflineEmergencyScreen({super.key});

  static const EmergencyNumber emergency =
      EmergencyNumber('Emergency', '112');
  static const EmergencyNumber ambulance =
      EmergencyNumber('Ambulance', '108');
  static const EmergencyNumber police =
      EmergencyNumber('Police', '100');

  static const List<EmergencyNumber> all = [
    emergency,
    ambulance,
    police,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Offline Emergency Mode'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: all.map((item) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () {
                // Dialer wiring already handled elsewhere
              },
              child: Text(
                '${item.label} (${item.number})',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
