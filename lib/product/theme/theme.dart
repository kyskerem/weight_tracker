import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

import '../constants/app_constants.dart';

class ProjectTheme {
  Future<ThemeData> lightThemeInit() async {
    final str = await rootBundle.loadString(lightThemePath);
    final json = jsonDecode(str);
    return ThemeDecoder.decodeThemeData(json)!;
  }

  Future<ThemeData> darkThemeInit() async {
    final str = await rootBundle.loadString(darkThemePath);
    final json = jsonDecode(str);
    return ThemeDecoder.decodeThemeData(json)!;
  }
}
