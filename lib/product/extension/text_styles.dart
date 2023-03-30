import 'package:flutter/material.dart';

extension TextStylesExtension on TextStyle {
  TextStyle get montserratw600s20 => const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  TextStyle get montserratw500s20 => const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get poppinsw500 =>
      const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500);
  TextStyle get poppinsw700 => const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );
  TextStyle get poppinsw300 => const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
        fontSize: 10,
      );

  TextStyle progressCardTextStyle(BuildContext context, String totalProgress) =>
      const TextStyle().montserratw500s20.copyWith(
            fontSize: 40,
            color: double.parse(totalProgress) < 0
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSecondaryContainer,
          );
}
