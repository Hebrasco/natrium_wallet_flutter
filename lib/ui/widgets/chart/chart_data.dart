import 'package:fl_chart/fl_chart.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartData {
  static getChartData(context) => LineChartBarData(
    spots: [
      FlSpot(0, 3),
      FlSpot(1, 2),
      FlSpot(2, 5),
      FlSpot(3, 2.5),
      FlSpot(5, 4),
      FlSpot(6, 3),
      FlSpot(7, 4),
      FlSpot(8, 2.6),
      FlSpot(9, 3.2),
      FlSpot(10, 1.8),
      FlSpot(11, 4),
      FlSpot(12, 9.9),
    ],
    isStrokeCapRound: true,
    isCurved: true,
    curveSmoothness: 0.5,
    preventCurveOverShooting: true,
    colors: [StateContainer.of(context).curTheme.primary],
    barWidth: 3,
    dotData: FlDotData(show: false),
  );
}