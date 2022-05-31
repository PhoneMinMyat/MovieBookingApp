class EnvironmentConfig {
  static const String kConfigThemeColor = String.fromEnvironment(
      'CONFIG_THEME_COLOR',
      defaultValue: 'THEME_GALAXY_COLOR');

  static const String kConfigWelcomeVector = String.fromEnvironment(
      'CONFIG_WELCOME_VECTOR',
      defaultValue: 'WELCOME_VECTOR_GALAXY');

  static const String kConfigMovieSectionView = String.fromEnvironment(
      'CONFIG_MOVIE_SECTION_VIEW',
      defaultValue: 'GALAXY_MOVIE_SECTION');

  static const String kConfigCastSectionView = String.fromEnvironment(
      'CONFIG_CAST_SECTION_VIEW',
      defaultValue: 'GALAXY_CAST_SECTION');

  static const String kConfigCardSectionView = String.fromEnvironment(
      'CONFIG_CARD_SECTION_VIEW',
      defaultValue: 'GALAXY_CARD_SECTION');
}

/// Flavours
/// 
/// GALAXY VERSION
/// flutter run --dart-define=CONFIG_THEME_COLOR=THEME_GALAXY_COLOR --dart-define=CONFIG_WELCOME_VECTOR=WELCOME_VECTOR_GALAXY --dart-define=CONFIG_MOVIE_SECTION_VIEW=GALAXY_MOVIE_SECTION --dart-define=CONFIG_CAST_SECTION_VIEW=GALAXY_CAST_SECTION --dart-define=CONFIG_CARD_SECTION_VIEW=GALAXY_CARD_SECTION
/// 
/// RUBY VERSION
/// flutter run --dart-define=CONFIG_THEME_COLOR=THEME_RUBY_COLOR --dart-define=CONFIG_WELCOME_VECTOR=WELCOME_VECTOR_RUBY --dart-define=CONFIG_MOVIE_SECTION_VIEW=RUBY_MOVIE_SECTION --dart-define=CONFIG_CAST_SECTION_VIEW=RUBY_CAST_SECTION --dart-define=CONFIG_CARD_SECTION_VIEW=RUBY_CARD_SECTION