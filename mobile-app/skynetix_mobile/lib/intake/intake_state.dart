/// All possible states of the online emergency intake flow.
///
/// Transitions must be explicit and controlled by IntakeController.
enum IntakeState {
  idle,
  recording,
  processing,
  completed,
  error,
}
