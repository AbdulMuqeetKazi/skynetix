// ===============================
// File: offline_mode.dart
// ===============================

/// Typed value object for an emergency phone contact.
///
/// This file is constants-only: no imports, no I/O, no storage.
class EmergencyContact {
  final String label;
  final String number;

  const EmergencyContact({
    required this.label,
    required this.number,
  });
}

/// Offline emergency contacts (India defaults requested).
class OfflineEmergencyContacts {
  const OfflineEmergencyContacts._();

  static const EmergencyContact emergency112 = EmergencyContact(
    label: 'Emergency',
    number: '112',
  );

  static const EmergencyContact ambulance108 = EmergencyContact(
    label: 'Ambulance',
    number: '108',
  );

  static const EmergencyContact police100 = EmergencyContact(
    label: 'Police',
    number: '100',
  );

  static const List<EmergencyContact> all = <EmergencyContact>[
    emergency112,
    ambulance108,
    police100,
  ];
}