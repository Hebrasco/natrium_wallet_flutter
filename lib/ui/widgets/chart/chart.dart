import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:natrium_wallet_flutter/appstate_container.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_data.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_history_selection.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_titles.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_touch_data.dart';

class PriceChartWidget extends StatefulWidget {
  @override
  PriceChartWidgetState createState() => PriceChartWidgetState();
}

class PriceChartWidgetState extends State<PriceChartWidget> {
  @override
  Widget build(BuildContext context) => Column(children: [
    ChartWidget(),
    ChartHistorySelection(),
  ]);
}

class ChartWidget extends StatefulWidget {
  @override
  ChartWidgetState createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) => Container(
    height: 350,
    width: MediaQuery.of(context).size.width,
    child: LineChart(
      LineChartData(
        minX: 0,
        maxX: StateContainer.of(context).chart.amountSteps,
        minY: StateContainer.of(context).chart.minValue,
        maxY: StateContainer.of(context).chart.maxValue,
        titlesData: PriceChartTitles.getTitleData(context),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: StateContainer.of(context).curTheme.background,
              strokeWidth: 0.5,
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
    ),
  );
}