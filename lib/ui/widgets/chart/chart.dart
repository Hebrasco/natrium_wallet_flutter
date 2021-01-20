import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_data.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_titles.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_touch_data.dart';

class PriceChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 13,
          minY: 0,
          maxY: 10,
          titlesData: PriceChartTitles.getTitleData(context),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: [PriceChartData.getChartData(context)],
          lineTouchData: PriceChartTouchData.getTouchData(context),
        ),
      );
}