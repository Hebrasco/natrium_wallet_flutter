import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';

class PriceChartTouchData {
  static getTouchData(BuildContext context)=> LineTouchData(
    enabled: true,
    touchTooltipData: PriceChartTooltipData.getTooltipData(context),
    getTouchedSpotIndicator: (barData, indicators) => PriceChartTouchedSpotIndicator.getTouchedSpotIndicator(context, barData, indicators),
  );
}

class PriceChartTooltipData {
  static getTooltipData(BuildContext context) => LineTouchTooltipData(
    tooltipBgColor: StateContainer.of(context).curTheme.primary20 ,
    getTooltipItems: (touchedSpots) => touchedSpots.map((LineBarSpot touchedSpot) {
      if (touchedSpot == null) {
        return null;
      }
      final TextStyle textStyle = TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      return LineTooltipItem(touchedSpot.y.toStringAsFixed(2), textStyle);
    }).toList()
  );
}

class PriceChartTouchedSpotIndicator {
  static getTouchedSpotIndicator(BuildContext context, LineChartBarData barData, List<int> indicators) => defaultTouchedIndicators(barData, indicators, context);

  static List<TouchedSpotIndicatorData> defaultTouchedIndicators(LineChartBarData barData, List<int> indicators, BuildContext context) {
    if (indicators == null) {
      return [];
    }
    return indicators.map((int index) {
      Color lineColor = StateContainer.of(context).curTheme.primary45;
      if (barData.dotData.show) {
        lineColor = Colors.black;
      }

      const double lineStrokeWidth = 3;
      final FlLine flLine = FlLine(color: lineColor, strokeWidth: lineStrokeWidth);

      double dotSize = 6;
      if (barData.dotData.show) {
        dotSize = 4.0 * 1.8;
      }

      final dotData = FlDotData(
          getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
            radius: dotSize,
            color: StateContainer.of(context).curTheme.primary,
            strokeColor: StateContainer.of(context).curTheme.primary,
          )
      );

      return TouchedSpotIndicatorData(flLine, dotData);
    }).toList();
  }
}
