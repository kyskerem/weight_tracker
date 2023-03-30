import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

extension GaugeTextStylesExtension on GaugeTextStyle {
  GaugeTextStyle get boldMontserrat20 => const GaugeTextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
}

extension MajorTickStylesExtension on MajorTickStyle {
  MajorTickStyle get appMajorTickStyle =>
      const MajorTickStyle(thickness: 3, length: 15);
}

extension MinorTickStyleExtension on MinorTickStyle {
  MinorTickStyle get appMinorTickStyle =>
      const MinorTickStyle(length: 12, thickness: 2);
}
