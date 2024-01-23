import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final int famCutoff;
  final List<FlSpot> famLineList;
  final bool isShowFam;
  final bool isShowCutoff;
  final int maxX;
  final int maxY;

  const ChartWidget(
      {Key? key,
      required this.famCutoff,
      required this.famLineList,
      required this.isShowFam,
      required this.isShowCutoff,
      this.maxX = 60,
      this.maxY = 60000})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 24,
              showTitles: true,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 45,
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
            show: true, border: Border.all(color: Colors.black, width: 1)),
        minY: -1000,
        maxY: maxY.toDouble(),
        minX: 0,
        maxX: maxX.toDouble(),
        extraLinesData: isShowCutoff
            ? ExtraLinesData(horizontalLines: [
                HorizontalLine(
                    y: famCutoff.toDouble(),
                    color: isShowFam
                        ? Colors.black.withGreen(100)
                        : Colors.black.withAlpha(0),
                    strokeWidth: 2,
                    dashArray: [10, 10],
                    label: HorizontalLineLabel(
                        show: isShowFam,
                        labelResolver: (h) {
                          return 'Fam Threshold';
                        })),
              ])
            : null,
        clipData: FlClipData.all(),
        lineBarsData: [
          LineChartBarData(
              isCurved: true,
              curveSmoothness: 0,
              color: Colors.green,
              show: isShowFam,
              dotData: FlDotData(show: false),
              spots: famLineList),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    Widget text;
    if ((value < 1 && value > 0) | ((value * 10).toInt() % 10 > 1)) {
      text = const Text(
        '',
        style: style,
      );
    } else {
      var f = NumberFormat("#,###", "en_US");
      text = Text(
        f.format(value.toInt()),
        style: style,
      );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    Widget text;
    if (value < 0) {
      text = const Text(
        '',
        style: style,
      );
    } else {
      var f = NumberFormat("#,###", "en_US");
      text = Text(
        f.format(value.toInt()),
        style: style,
      );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }
}
