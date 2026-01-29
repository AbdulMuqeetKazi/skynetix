import 'package:flutter/material.dart';
import 'offline/offline_emergency_screen.dart';
import 'offline/connectivity_service.dart';

void main() {
  runApp(const SkynetixApp());
}

class SkynetixApp extends StatelessWidget {
  const SkynetixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<bool>(
        stream: ConnectivityService().isOnline,
        initialData: true,
        builder: (context, snapshot) {
          final isOnline = snapshot.data ?? false;

          if (!isOnline) {
            return const OfflineEmergencyScreen();
          }

          // Online placeholder (INTENTIONALLY EMPTY)
          return const Scaffold(
            body: Center(
              child: Text(
                'Online mode (under development)',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
