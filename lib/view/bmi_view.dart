import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../product/cache/record_manager.dart';
import '../product/cache/user_manager.dart';
import '../product/extension/gauge.dart';
import '../product/extension/text_styles.dart';

class BmiView extends StatefulWidget {
  const BmiView({super.key});

  @override
  State<BmiView> createState() => _BmiViewState();
}

class _BmiViewState extends State<BmiView> {
  double? get height => UserManager.getInstance().user?.height;

  bool noRecord(BuildContext context) => lastWeight(context) == null;

  double? lastWeight(BuildContext context) {
    final recordList = Provider.of<RecordManager>(context).recordList;
    if (recordList.isEmpty) {
      return null;
    }
    return recordList.last.weight;
  }

  double heightsqr(double height) {
    return height * height;
  }

  double _getValue(BuildContext context) {
    if (noRecord(context)) {
      return 0;
    }
    return lastWeight(context)! / heightsqr(height ?? 0);
  }

  String _valueToString(BuildContext context) {
    return _getValue(context).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    const bodyMassIndexmessage = 'BODY MASS INDEX';
    const noBMI = 'Add a record to see your BMI';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: noRecord(context)
            ? [
                const Center(
                  child: Text(
                    noBMI,
                  ),
                )
              ]
            : [
                const Spacer(
                  flex: 4,
                ),
                SfRadialGauge(
                  animationDuration: 2,
                  enableLoadingAnimation: true,
                  axes: _axes(context),
                ),
                Tooltip(
                  message: bodyMassIndexmessage,
                  child: Text(
                    _valueToString(context),
                    style: const TextStyle().progressCardTextStyle(
                      context,
                      _valueToString(context),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 5,
                )
              ],
      ),
    );
  }

  List<RadialAxis> _axes(BuildContext context) {
    return [
      RadialAxis(
        canScaleToFit: true,
        minorTicksPerInterval: 5,
        axisLabelStyle: const GaugeTextStyle().boldMontserrat20,
        canRotateLabels: true,
        interval: 10,
        maximum: 40,
        startAngle: 180,
        endAngle: 0,
        pointers: [
          NeedlePointer(
            enableAnimation: true,
            animationType: AnimationType.linear,
            animationDuration: 1200,
            value: _getValue(context),
          )
        ],
        majorTickStyle: const MajorTickStyle().appMajorTickStyle,
        minorTickStyle: const MinorTickStyle().appMinorTickStyle,
        ranges: _ranges(context),
      ),
    ];
  }

  List<GaugeRange> _ranges(BuildContext context) {
    const overWeightLabel = 'OverWeight';
    const underWeightLabel = 'UnderWeight';
    const normalWeightLabel = 'Normal';
    const obesityLabel = 'Obesity';

    return <GaugeRange>[
      GaugeRange(
        startValue: 0,
        endValue: 12,
        color: Colors.red[900],
        label: underWeightLabel,
      ),
      GaugeRange(
        startValue: 12,
        endValue: 18.5,
        color: Colors.red[800],
        label: underWeightLabel,
      ),
      GaugeRange(
        startValue: 18.5,
        endValue: 25,
        label: normalWeightLabel,
        color: Colors.red[600],
      ),
      GaugeRange(
        startValue: 25,
        endValue: 30,
        color: Colors.red[700],
        label: overWeightLabel,
      ),
      GaugeRange(
        startValue: 30,
        endValue: 35,
        color: Colors.red[800],
        label: obesityLabel,
      ),
      GaugeRange(
        startValue: 35,
        endValue: 50,
        color: Colors.red[900],
        label: obesityLabel,
      ),
    ];
  }
}
