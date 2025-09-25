class AppConstants {
  // API Configuration
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Cache Configuration
  static const int cacheMaxAge = 300; // 5 minutes
  static const String cacheControlHeader = 'Cache-Control';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Educational System Constants
  static const List<String> educationLevels = [
    'primary',
    'middle',
    'secondary',
  ];

  static const List<String> systemTypes = [
    'public',
    'private',
    'international',
  ];

  static const List<String> trackTypes = [
    'scientific',
    'literary',
    'administrative',
  ];

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}