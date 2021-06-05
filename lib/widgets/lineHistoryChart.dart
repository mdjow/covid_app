import 'package:covid_app/utils/format.dart';
import "package:flutter/material.dart";
import "package:fl_chart/fl_chart.dart";

class LineHistoryChart extends StatelessWidget {
  final List<Color> gradientColors = [
    Colors.blueAccent,
    Colors.lightBlueAccent,
  ];
  final List<double> points;
  final String chartLabel;
  final String infoLabel;

  LineHistoryChart({
    @required this.points,
    this.chartLabel = "",
    this.infoLabel = "",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            chartLabel,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey[200]),
          ),
        ),
        AspectRatio(
          aspectRatio: 2.0,
          child: Container(
            padding: EdgeInsets.only(top: 32, bottom: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: LineChart(mainData(points)),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<double> spots) {
    var spots = <FlSpot>[];
    var maxX = points.length.toDouble() - 1;
    var minX = 0.0;
    var maxY = points[0];
    var minY = points[0];

    for (var i = 0; i < points.length; i++) {
      if (maxY < points[i]) {
        maxY = points[i];
      }

      if (minY > points[i]) {
        minY = points[i];
      }

      spots.add(FlSpot(i.toDouble(), points[i]));
    }

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueAccent,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == minX || flSpot.x == maxX) {
                return null;
              }

              return LineTooltipItem(
                "${numberFormat(flSpot.y.toInt())} \n $infoLabel",
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            checkToShowDot: (FlSpot flSpot, LineChartBarData lineChartBarData) {
              if (flSpot.x == minX || flSpot.x == maxX) {
                return false;
              }

              return true;
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
