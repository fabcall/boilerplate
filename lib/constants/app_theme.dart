import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/font_family.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  primarySwatch: MaterialColor(AppColors.orange[500]!.value, AppColors.orange),
  brightness: Brightness.light,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color(0xfffee3cd),
  primaryColorDark: Color(0xff974602),
  accentColor: Color(0xff6e6d76),
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xfffafafa),
  scaffoldBackgroundColor: Color(0xfffafafa),
  bottomAppBarColor: Color(0xffffffff),
  cardColor: Color(0xffffffff),
  dividerColor: Color(0x1f000000),
  highlightColor: Color(0x66bcbcbc),
  splashColor: Color(0x66c8c8c8),
  selectedRowColor: Color(0xfff5f5f5),
  unselectedWidgetColor: Color(0x8a000000),
  disabledColor: Color(0x61000000),
  buttonColor: Color(0xffe0e0e0),
  toggleableActiveColor: Color(0xffc95d03),
  secondaryHeaderColor: Color(0xfffff1e6),
  backgroundColor: Color(0xfffec79a),
  dialogBackgroundColor: Color(0xffffffff),
  indicatorColor: Color(0xfffb7404),
  hintColor: Color(0x8a000000),
  errorColor: Color(0xffd32f2f),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffffffff),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      elevation: 0,
      shape: StadiumBorder(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      shape: StadiumBorder(),
      primary: Colors.black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      shape: StadiumBorder(),
      primary: Colors.grey,
    ),
  ),
  colorScheme: ColorScheme(
    primary: Color(0xfffc8c2f),
    primaryVariant: Color(0xff974602),
    secondary: Color(0xfffb7404),
    secondaryVariant: Color(0xff974602),
    surface: Color(0xffffffff),
    background: Color(0xfffec79a),
    error: Color(0xffd32f2f),
    onPrimary: Color(0xffffffff),
    onSecondary: Color(0xffffffff),
    onSurface: Color(0xff000000),
    onBackground: Color(0xff000000),
    onError: Color(0xffffffff),
    brightness: Brightness.light,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderSide: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        gapPadding: 4),
    isDense: true,
  ),
  iconTheme: IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: IconThemeData(
    color: Color(0xff000000),
    opacity: 1,
    size: 24,
  ),
  accentIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xff4285f4),
    selectionColor: Color(0xfffec79a),
    selectionHandleColor: Color(0xfffdac68),
  ),
);

final ThemeData themeDataDark = ThemeData(
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);
