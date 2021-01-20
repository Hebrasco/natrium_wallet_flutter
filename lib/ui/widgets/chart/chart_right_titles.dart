import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartRightTitles {
  static getRightTitles(context) => SideTitles(
    showTitles: true,
    getTextStyles: (value) => TextStyle(
      color: StateContainer.of(context).curTheme.primary,
    ),
    getTitles: (value) {
      return value.toString();
    },
    reservedSize: 35,
    margin: 12,
  );
}