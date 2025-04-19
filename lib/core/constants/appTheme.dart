class appTheme {

  appTheme._privateConstructor();

  static final appTheme _theme = appTheme._privateConstructor();

  factory appTheme() {
    return _theme;
  }

  String _appTheme = '';

  // Getter method to access the private field
  String get theme => _appTheme;

  // Setter method to modify the private field
  set theme(String value) {
    _appTheme = value;
  }
}

