import '../enums/emergency_type.dart';
import '../enums/severity_level.dart';

class EmergencySession {
  final String sessionId;
  final DateTime createdAt;
  final EmergencyType type;
  final SeverityLevel severity;
  final String description;

  const EmergencySession({
    required this.sessionId,
    required this.createdAt,
    required this.type,
    required this.severity,
    required this.description,
  });
}
