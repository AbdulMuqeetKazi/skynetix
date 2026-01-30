/// High-level category of emergency.
///
/// This enum is intentionally small and conservative.
/// More types can be added later without breaking compatibility.
enum EmergencyType {
  medical,
  police,
  fire,
  disaster,
  unknown,
}
