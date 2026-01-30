import 'intake_state.dart';

/// Controls transitions for the emergency intake flow.
///
/// IMPORTANT:
/// - No async logic yet
/// - No services
/// - No UI
/// - No side effects
class IntakeController {
  IntakeState _state = IntakeState.idle;

  IntakeState get state => _state;

  void startRecording() {
    if (_state != IntakeState.idle) return;
    _state = IntakeState.recording;
  }

  void stopRecording() {
    if (_state != IntakeState.recording) return;
    _state = IntakeState.processing;
  }

  void complete() {
    if (_state != IntakeState.processing) return;
    _state = IntakeState.completed;
  }

  void fail() {
    _state = IntakeState.error;
  }

  void reset() {
    _state = IntakeState.idle;
  }
}
