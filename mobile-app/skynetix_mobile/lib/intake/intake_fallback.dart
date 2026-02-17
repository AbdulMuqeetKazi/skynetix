import 'package:flutter/material.dart';
import '../offline/offline_emergency_screen.dart';

class IntakeFallback {
  static void toOffline(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const OfflineEmergencyScreen(),
      ),
      (_) => false,
    );
  }
}
