enum Theme {
  dark,
  light,
  system
}

extension ThemeJsonExtension on Theme {
  String toJson() {
    switch (this) {
      case Theme.light:
        return 'light';
      case Theme.dark:
        return 'dark';
      case Theme.system:
        return 'system';
    }
  }

  static Theme fromJson(String json) {
    switch (json) {
      case 'light':
        return Theme.light;
      case 'dark':
        return Theme.dark;
      case 'system':
        return Theme.system;
      default:
        throw FormatException('Invalid theme value: $json');
    }
  }
}