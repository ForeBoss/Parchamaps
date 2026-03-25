abstract final class AppConstants {
  static const String appName = 'ParchaMaps';
  static const String appTagline = 'Planes reales cerca de ti';

  // ── Geolocation ──
  static const double defaultLatitude = 4.7110;
  static const double defaultLongitude = -74.0721;
  static const double defaultZoom = 14.0;
  static const double checkinRadiusMeters = 100.0;
  static const double nearbyRadiusKm = 10.0;

  // ── Onboarding ──
  static const int minAge = 16;
  static const int maxAge = 99;
  static const int maxInterests = 8;
  static const int minInterests = 3;
  static const int maxPhotos = 6;

  // ── Events ──
  static const int maxEventTitleLength = 80;
  static const int maxEventDescriptionLength = 500;
  static const int maxEventCapacity = 1000;
  static const int defaultEventDurationHours = 3;
  static const int maxEventImages = 5;

  // ── Chat ──
  static const int maxMessageLength = 1000;
  static const int chatPageSize = 30;

  // ── Feed ──
  static const int feedPageSize = 20;

  // ── Storage Keys ──
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLastLocation = 'last_location';
}
