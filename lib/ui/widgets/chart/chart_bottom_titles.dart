import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartBottomTitles {
  static getBottomTitles(BuildContext context) => SideTitles(
    showTitles: true,
    reservedSize: 35,
    getTextStyles: (value) => TextStyle(
      color: StateContainer.of(context).curTheme.primary,
    ),
    getTitles: (value) {
      return StateContainer.of(context).chart.getBottomTitles(value);
    },
    margin: 8,
  );
}