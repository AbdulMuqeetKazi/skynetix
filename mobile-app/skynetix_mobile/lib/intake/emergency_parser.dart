// =======================================================
// FILE: intake/emergency_parser.dart
// =======================================================

import '../core/enums/emergency_type.dart';
import '../core/enums/severity_level.dart';

/// Immutable result of rules-based parsing of raw user text.
///
/// Represents a structured emergency signal only.
/// No routing, escalation, or responder logic.
class ParsedEmergency {
  /// Classified emergency type from rules; [EmergencyType.unknown] if unclear.
  final EmergencyType type;

  /// Classified severity from rules; safe default if unclear.
  final SeverityLevel severity;

  /// Parsing confidence in range 0.0–1.0; clamped by parser.
  final double confidence;

  const ParsedEmergency({
    required this.type,
    required this.severity,
    required this.confidence,
  });
}

/// Rules-based parser for raw emergency text. No AI, fully deterministic.
///
/// Converts user text into [ParsedEmergency]. Empty or invalid input
/// returns safe defaults; never throws.
class EmergencyParser {
  const EmergencyParser();
  /// Parses [input] into a structured [ParsedEmergency].
  ///
  /// Safe for any string; returns defaults for empty or bad input.
  /// Confidence is always in [0.0, 1.0].
  ParsedEmergency parse(String input) {
    final normalized = input.trim().toLowerCase();
    final type = _detectType(normalized);
    final severity = _detectSeverity(normalized);
    final confidence = _estimateConfidence(normalized, type, severity);
    return ParsedEmergency(
      type: type,
      severity: severity,
      confidence: confidence.clamp(0.0, 1.0),
    );
  }

  EmergencyType _detectType(String text) {
    if (text.isEmpty) return EmergencyType.unknown;
    if (_matchesAny(text, ['fire', 'smoke', 'burn', 'explosion'])) {
      return EmergencyType.fire;
    }
    if (_matchesAny(text, ['police', 'crime', 'theft', 'assault', 'robbery'])) {
      return EmergencyType.police;
    }
    if (_matchesAny(text, [
      'disaster', 'earthquake', 'flood', 'hurricane', 'tornado', 'tsunami'
    ])) {
      return EmergencyType.disaster;
    }
    if (_matchesAny(text, [
      'medical', 'heart', 'accident', 'injured', 'bleeding', 'unconscious',
      'ambulance', 'stroke', 'choking', 'allergic'
    ])) {
      return EmergencyType.medical;
    }
    return EmergencyType.unknown;
  }

  SeverityLevel _detectSeverity(String text) {
    if (text.isEmpty) return SeverityLevel.medium;
    if (_matchesAny(text, ['critical', 'dying', 'unconscious', 'not breathing'])) {
      return SeverityLevel.critical;
    }
    if (_matchesAny(text, ['serious', 'urgent', 'emergency', 'help me'])) {
      return SeverityLevel.high;
    }
    if (_matchesAny(text, ['help', 'need', 'please'])) {
      return SeverityLevel.medium;
    }
    return SeverityLevel.medium;
  }

  double _estimateConfidence(String text, EmergencyType type, SeverityLevel severity) {
    if (text.isEmpty) return 0.0;
    var score = 0.0;
    if (type != EmergencyType.unknown) score += 0.5;
    if (text.length >= 3) score += 0.2;
    if (text.length >= 10) score += 0.2;
    if (severity != SeverityLevel.medium) score += 0.1;
    return score.clamp(0.0, 1.0);
  }

  bool _matchesAny(String text, List<String> keywords) {
    for (final k in keywords) {
      if (text.contains(k)) return true;
    }
    return false;
  }
}