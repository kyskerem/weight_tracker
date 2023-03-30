// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weight_tracker/product/enums/edge_insets.dart';
import 'package:weight_tracker/product/extension/text_styles.dart';

import '../../core/model/record_model.dart';

class ProgressTile extends StatelessWidget {
  const ProgressTile({
    super.key,
    required this.showedRecords,
  });
  final List<Record> showedRecords;

  String getProgress() {
    if (showedRecords.isEmpty) {
      return '0.00';
    }
    return (showedRecords.last.weight - showedRecords.first.weight)
        .toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    const progressText = 'Progress';
    return ExpansionTile(
      title: const Text(progressText),
      children: [
        Padding(
          padding: EdgeInsetsValues.appPadding.value(),
          child: Text(
            getProgress(),
            style: const TextStyle().progressCardTextStyle(
              context,
              getProgress(),
            ),
          ),
        ),
      ],
    );
  }
}
