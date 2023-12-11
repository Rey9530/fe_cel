import 'package:flutter/material.dart';
import 'package:marcacion_admin/src/common/const/const.dart';

ColorScheme getTheme(context) {
  return Theme.of(context).colorScheme;
}

ThemeData setTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: whiteColor,
      primary: primary,
      tertiary: tertiary,
      secondary: secondary,
    ).copyWith(),
    useMaterial3: true,
    fontFamily: museoSans,
  );
}
