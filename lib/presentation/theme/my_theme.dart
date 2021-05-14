import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTheme {
  late final MaterialColor _materialColor;
  late final MaterialAccentColor _accentColor;
  late final ThemeData _themeData;
  final bool isDark;

  ThemeData get theme => _themeData;

  factory MyTheme.init(bool isDark) {
    return isDark ? MyTheme.dark() : MyTheme.light();
  }

  MyTheme.light() : isDark = false {
    _materialColor = _createMaterialColor(Color(0xff572b9f));
    _accentColor = _createMaterialAccentColor(Color(0xffff7552));
    final typography = Typography.material2018(platform: defaultTargetPlatform);
    _themeData = ThemeData.from(
      textTheme: typography.black.apply(fontFamily: 'Montserrat'),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _materialColor,
        primaryColorDark: _materialColor.shade700,
        accentColor: _accentColor,
        cardColor: Colors.white,
        backgroundColor: Colors.white,
        errorColor: Colors.red.shade700,
        brightness: Brightness.light,
      ),
    ).copyWith(
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
    );
  }

  MyTheme.dark() : isDark = true {
    _materialColor = _createMaterialColor(Color(0xffcc26e6));
    _accentColor = _createMaterialAccentColor(Color(0xffffbd6c));
    final typography = Typography.material2018(platform: defaultTargetPlatform);
    _themeData = ThemeData.from(
      textTheme: typography.white.apply(fontFamily: 'Montserrat'),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _materialColor,
        primaryColorDark: _materialColor.shade700,
        accentColor: _accentColor,
        cardColor: Color(0xff121212),
        backgroundColor: Colors.black,
        errorColor: Color(0xffcf6679),
        brightness: Brightness.dark,
      ),
    ).copyWith(
      toggleableActiveColor: _accentColor,
      checkboxTheme: CheckboxThemeData().copyWith(
        checkColor: MaterialStateColor.resolveWith((states) => Colors.black),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTheme &&
          runtimeType == other.runtimeType &&
          _materialColor == other._materialColor &&
          _accentColor == other._accentColor &&
          _themeData == other._themeData;

  @override
  int get hashCode =>
      _materialColor.hashCode ^ _accentColor.hashCode ^ _themeData.hashCode;

  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = [.05];
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    final swatches = _generateSwatches(color, strengths);
    return MaterialColor(color.value, swatches);
  }

  MaterialAccentColor _createMaterialAccentColor(Color color) {
    List<double> strengths = [];
    for (int i = 0; i < 4; i++) {
      final last = strengths.lastWhere((_) => true, orElse: () => 0.1);
      strengths.add(last + i * 0.1);
    }
    Map<int, Color> swatches = _generateSwatches(color, strengths);
    return MaterialAccentColor(color.value, swatches);
  }

  Map<int, Color> _generateSwatches(Color color, List<double> strengths) {
    Map<int, Color> swatches = {};
    final int r = color.red, g = color.green, b = color.blue;
    strengths.forEach((strength) {
      final ds = 0.5 - strength;
      swatches[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return swatches;
  }
}
