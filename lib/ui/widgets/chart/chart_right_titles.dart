import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartRightTitles {
  static getRightTitles(context) => SideTitles(
    showTitles: true,
    getTextStyles: (value) => TextStyle(
      color: StateContainer.of(context).curTheme.primary,
      // fontWeight: FontWeight.bold,
      // fontSize: 12,
    ),
    getTitles: (value) {
      switch (value.toInt()) {
        case 1:
          return '10k';
        case 3:
          return '30k';
        case 5:
          return '50k';
      }
      return '';
    },
    reservedSize: 35,
    margin: 12,
  );
}