// ===============================
// File: native_dialer.dart
// ===============================

import 'package:url_launcher/url_launcher.dart';

/// Native dialer launcher using the `tel:` scheme.
///
/// Requirements:
/// - Must not throw exceptions
/// - Must fail silently if it cannot launch
/// - No logging, no dialogs, no permission handling
class NativeDialer {
  const NativeDialer._();

  static Future<void> dial(String phoneNumber) async {
    try {
      final normalized = phoneNumber.trim();
      if (normalized.isEmpty) {
        return;
      }

      final uri = Uri(scheme: 'tel', path: normalized);
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        return;
      }

      // External application is the safest way to hand off to the dialer.
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Fail silently by design.
      return;
    }
  }
}