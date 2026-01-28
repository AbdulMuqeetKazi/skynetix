export interface EmergencySession {
  sessionId: string;
  createdAt: string;
  location?: {
    lat: number;
    lng: number;
  };
  status: 'CREATED' | 'CLASSIFIED' | 'ASSIGNED' | 'ESCALATED' | 'RESOLVED';
}
