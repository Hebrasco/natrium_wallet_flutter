import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/model/chart.dart';

class PriceChartData {
  static getChartData(BuildContext context) => LineChartBarData(
    spots: StateContainer.of(context).chart.spots,
    isStrokeCapRound: true,
    isCurved: true,
    curveSmoothness: 0.5,
    preventCurveOverShooting: true,
    colors: [StateContainer.of(context).curTheme.primary],
    barWidth: 3,
    dotData: FlDotData(show: false),
  );
}