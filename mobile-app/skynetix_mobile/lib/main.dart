import 'package:flutter/material.dart';

import 'offline/connectivity_service.dart';
import 'offline/offline_emergency_screen.dart';
import 'intake/intake_screen.dart';

void main() {
  runApp(const SkynetixApp());
}

class SkynetixApp extends StatelessWidget {
  const SkynetixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<bool>(
        stream: ConnectivityService().isOnline,
        initialData: true,
        builder: (context, snapshot) {
          final isOnline = snapshot.data ?? false;

          if (!isOnline) {
            return const OfflineEmergencyScreen();
          }

          // 🔵 Phase C3 starts here
          return const IntakeScreen();
        },
      ),
    );
  }
}
