import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartRightTitles {
  static getRightTitles(BuildContext context) => SideTitles(
    showTitles: true,
    getTextStyles: (value) => TextStyle(
      color: StateContainer.of(context).curTheme.primary,
    ),
    getTitles: (value) {
      return StateContainer.of(context).curCurrency.getCurrencySymbol() + value.toStringAsFixed(2).toString();
    },
    reservedSize: 35,
    margin: 12,
  );
}