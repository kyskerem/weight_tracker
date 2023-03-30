import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/model/record_model.dart';
import '../product/cache/record_manager.dart';
import '../product/components/line_chart.dart';
import '../product/components/progress_tile.dart';
import '../product/extension/text_styles.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  int? showThisMuchRecord;
  bool get canExpand => _showThisMuch > 20;
  List<Record> get _recordList =>
      Provider.of<RecordManager>(context).recordList;
  int get _showThisMuch =>
      showThisMuchRecord ?? (_recordList.length < 20 ? _recordList.length : 20);
  Widget get _chart => canExpand
      ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: LineChartWidget(
            showThisMuchRecord: _showThisMuch,
            canExpand: canExpand,
          ),
        )
      : LineChartWidget(
          canExpand: canExpand,
          showThisMuchRecord: _showThisMuch,
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _chart,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                dropdownColor: Theme.of(context).highlightColor,
                style: const TextStyle()
                    .progressCardTextStyle(context, _showThisMuch.toString())
                    .copyWith(fontSize: 20),
                value: showThisMuchRecord ?? 20,
                items: [
                  DropdownMenuItem(
                    enabled: _recordList.length >= 20,
                    value: 20,
                    child: const Text('20'),
                  ),
                  DropdownMenuItem(
                    enabled: _recordList.length >= 40,
                    value: 40,
                    child: const Text('40'),
                  ),
                  DropdownMenuItem(
                    enabled: _recordList.length >= 60,
                    value: 60,
                    child: const Text('60'),
                  ),
                  DropdownMenuItem(
                    enabled: _recordList.length >= 90,
                    value: 90,
                    child: const Text('90'),
                  )
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    showThisMuchRecord = value;
                  });
                },
              ),
              ProgressTile(
                showedRecords: _recordList
                    .getRange(
                      _recordList.length - _showThisMuch,
                      _recordList.length,
                    )
                    .toList(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
