import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => width * percent;
  double percentHeight(double percent) => height * percent;
}
