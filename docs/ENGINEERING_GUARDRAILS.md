# ENGINEERING_GUARDRAILS.md

## 1. Offline Safety (Absolute Rule)
- Offline mode SHALL use the device’s native phone dialer only.
- Offline mode SHALL NOT make any backend calls.
- Offline mode SHALL NOT invoke any AI processing.
- Offline mode SHALL NOT create, store, or sync incident data.
- Offline mode SHALL NOT perform background operations of any kind.
- Emergency numbers (112 / 108 / 100) SHALL always be accessible offline.

## 2. Online vs Offline Separation
- Online and offline modes SHALL be strictly separated.
- Offline mode SHALL NEVER degrade into partial online behavior.
- Online features SHALL NOT be required for emergency access.

## 3. AI Usage Limits
- AI SHALL assist decision-making only.
- AI SHALL NEVER block or delay emergency access.
- AI outputs SHALL include confidence scores.
- Low-confidence AI results SHALL trigger escalation, not retries.
- AI SHALL NOT perform autonomous authority actions.
- All AI decisions SHALL be logged.

## 4. Escalation Guarantee
- Every emergency SHALL have a defined escalation path.
- Lack of responder response SHALL ALWAYS trigger escalation.
- Silent failure is NOT permitted.
- Final escalation SHALL fall back to standard emergency numbers.

## 5. Ownership Locking
- Each incident SHALL have only one active responder at any time.
- Ownership SHALL be granted to the first responder who accepts.
- Concurrent ownership is NOT permitted.
- Ownership SHALL expire on timeout or explicit release.
- Ownership release SHALL immediately trigger escalation.

## 6. Complaint Handling
- The system SHALL only assist users in preparing complaints.
- The system SHALL NOT file complaints on behalf of users.
- The system SHALL NOT impersonate any authority.
- Complaint submission SHALL always be user-controlled.

## 7. Data & Privacy Enforcement
- Personal and incident data SHALL be encrypted at rest and in transit.
- Offline mode SHALL NOT persist any data.
- Only minimum data required for response SHALL be shared.
- Non-essential data SHALL be purged after incident resolution.

## 8. Safety Over Features
- Emergency access SHALL take priority over all features.
- No feature is allowed if it compromises offline safety.
- No feature is allowed if it weakens escalation guarantees.
- No feature is allowed if it increases user risk.
