import '../core/models/emergency_session.dart';
import '../core/enums/emergency_type.dart';
import '../core/enums/severity_level.dart';
import 'intake_state.dart';
import 'emergency_parser.dart';

/// Controls transitions for the emergency intake flow.
///
/// FINAL PHASE C5 RULES:
/// - No navigation
/// - No async
/// - No side effects
/// - Never throws
/// - Parser is wired here
class IntakeController {
  final EmergencyParser _parser = const EmergencyParser();

  IntakeState _state = IntakeState.idle;
  EmergencySession? _session;

  IntakeState get state => _state;
  EmergencySession? get session => _session;

  void startRecording() {
    if (_state != IntakeState.idle) return;
    _state = IntakeState.recording;
  }

  void stopRecording() {
    if (_state != IntakeState.recording) return;
    _state = IntakeState.processing;
  }

  void complete(String rawText) {
    if (_state != IntakeState.processing) return;

    try {
      final parsed = _parser.parse(rawText);

      _session = EmergencySession(
        sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        type: parsed.type,
        severity: parsed.severity,
        description: rawText.trim().isEmpty
            ? '(no description)'
            : rawText.trim(),
      );

      _state = IntakeState.completed;
    } catch (_) {
      _state = IntakeState.error;
    }
  }

  void fail() {
    if (_state == IntakeState.recording ||
        _state == IntakeState.processing) {
      _state = IntakeState.error;
    }
  }

  void reset() {
    _session = null;
    _state = IntakeState.idle;
  }
}