import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartBottomTitles {
  static getBottomTitles(context) => SideTitles(
    showTitles: true,
    reservedSize: 35,
    getTextStyles: (value) => TextStyle(
      color: StateContainer.of(context).curTheme.primary,
      // fontWeight: FontWeight.bold,
      // fontSize: 12,
    ),
    getTitles: (value) {
      switch (value.toInt()) {
        case 1: 
          return 'JAN';
        // case 2:
        //   return 'FEB';
        case 3:
          return 'MAR';
        // case 4:
        //   return 'APR';
        case 5:
          return 'MAY';
        // case 6:
        //   return 'JUN';
        case 7:
          return 'JUL';
        // case 8:
        //   return 'AUG';
        case 9:
          return 'SEP';
        // case 10:
        //   return 'OCT';
        case 11:
          return 'NOV';
        // case 12:
        //   return 'DEC';
      }
      return '';
    },
    margin: 8,
  );
}