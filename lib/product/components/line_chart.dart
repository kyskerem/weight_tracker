import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/model/chart_points.dart';
import '../../core/model/record_model.dart';
import '../cache/record_manager.dart';
import '../extension/context_extension.dart';
import '../extension/text_styles.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.canExpand,
    required this.showThisMuchRecord,
  });
  final bool canExpand;
  final int showThisMuchRecord;
  bool _isListSmaller(BuildContext context) {
    return list(context).length <= showThisMuchRecord;
  }

  int _substractAmount(BuildContext context) {
    return _isListSmaller(context) ? 0 : 1;
  }

  List<Record> list(BuildContext context) {
    return Provider.of<RecordManager>(context).recordList;
  }

  List<Record> data(BuildContext context) {
    return list(context)
        .getRange(
          list(context).length - showThisMuchRecord - _substractAmount(context),
          list(context).length,
        )
        .toList()
        .reversed
        .toList();
  }

  List<ChartPoints> points(BuildContext context) {
    return data(context)
        .toList()
        .map(
          (e) => ChartPoints(
            x: data(context).indexOf(e) - list(context).length,
            y: e.weight,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = <Color>[
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary
    ];

    return Container(
      transformAlignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(0, 10, 25, 10),
      width: canExpand
          ? data(context).length * 20
          : context.dynamicWidth(context, .9),
      height: MediaQuery.of(context).size.height / 2.15,
      child: LineChart(_Chart(context, points(context), gradientColors)),
    );
  }
}

class _Chart extends LineChartData {
  _Chart(
    BuildContext context,
    List<ChartPoints> points,
    List<Color> gradientColors,
  ) : super(
          backgroundColor: Theme.of(context).colorScheme.background,
          lineTouchData: _TouchData(context, points),
          lineBarsData: [_ChartBarData(points, gradientColors, context)],
          titlesData: _TitleData(),
          gridData: FlGridData(show: false),
        );
}

class _TouchData extends LineTouchData {
  _TouchData(BuildContext context, List<ChartPoints> points)
      : super(
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 80,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            tooltipBgColor: Theme.of(context).canvasColor,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map(
                (LineBarSpot touchedSpot) {
                  final x = points[touchedSpot.spotIndex].x;
                  final y = points[touchedSpot.spotIndex].y.toStringAsFixed(1);
                  return LineTooltipItem(
                    '$y\n${x.abs()}',
                    const TextStyle().poppinsw500,
                  );
                },
              ).toList();
            },
          ),
        );
}

class _ChartBarData extends LineChartBarData {
  _ChartBarData(
    List<ChartPoints> points,
    List<Color> gradientColors,
    BuildContext context,
  ) : super(
          preventCurveOverShooting: true,
          isCurved: true,
          spots: points
              .map(
                (point) => FlSpot(point.x.toDouble(), point.y),
              )
              .toList(),
          barWidth: 2,
          gradient: LinearGradient(colors: gradientColors),
          belowBarData: _BarAreaData(gradientColors),
          shadow: BoxShadow(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            blurRadius: 5,
          ),
          dotData: _DotData(context),
        );
}

class _BarAreaData extends BarAreaData {
  _BarAreaData(List<Color> gradientColors)
      : super(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors
                .map((color) => color.withOpacity(0.405))
                .toList(),
          ),
        );
}

class _DotData extends FlDotData {
  _DotData(BuildContext context)
      : super(
          show: true,
          getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
            radius: 2,
            strokeWidth: 1,
            strokeColor: Theme.of(context).colorScheme.onPrimaryContainer,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        );
}

class _TitleData extends FlTitlesData {
  _TitleData()
      : super(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return _GetBottomTitleWidget(value);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return _GetLeftTitleWidget(value);
              },
            ),
          ),
        );
}

class _GetLeftTitleWidget extends Text {
  _GetLeftTitleWidget(double value)
      : super(
          value.toStringAsFixed(0),
          style: const TextStyle().poppinsw300,
        );
}

class _GetBottomTitleWidget extends Text {
  _GetBottomTitleWidget(double value)
      : super(
          '${value.abs().toInt()}',
          style: const TextStyle().poppinsw300,
        );
}
