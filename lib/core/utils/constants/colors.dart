import 'package:flutter/material.dart';

abstract class ColorManager {
  const ColorManager._();
  static Color dark = Colors.grey.shade900;
  static Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color purple = Colors.purple;

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
}
