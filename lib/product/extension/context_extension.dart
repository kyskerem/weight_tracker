import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(BuildContext context, double value) =>
      MediaQuery.of(context).size.height * value;
  double dynamicWidth(BuildContext context, double value) =>
      MediaQuery.of(context).size.width * value;
}
