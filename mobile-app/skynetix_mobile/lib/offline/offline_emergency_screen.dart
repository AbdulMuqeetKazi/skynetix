class EmergencyNumber {
  final String label;
  final String number;

  const EmergencyNumber(this.label, this.number);
}

class OfflineEmergencyNumbers {
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
}