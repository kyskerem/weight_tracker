import 'package:flutter/material.dart';

enum EdgeInsetsValues {
  appPadding,
  recordDatePadding,
  listTileContentPadding,
  recordNotePadding,
  bAppBarIconsPadding,
}

extension EdgeInsetsValuesExtension on EdgeInsetsValues {
  EdgeInsets value() {
    switch (this) {
      case EdgeInsetsValues.appPadding:
        return const EdgeInsets.symmetric(horizontal: 15, vertical: 20);
      case EdgeInsetsValues.recordDatePadding:
        return const EdgeInsets.symmetric(horizontal: 10);
      case EdgeInsetsValues.listTileContentPadding:
        return const EdgeInsets.all(15);
      case EdgeInsetsValues.recordNotePadding:
        return const EdgeInsets.symmetric(horizontal: 15);
      case EdgeInsetsValues.bAppBarIconsPadding:
        return const EdgeInsets.all(15);
    }
  }
}
