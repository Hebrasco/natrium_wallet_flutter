import 'package:fl_chart/fl_chart.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_bottom_titles.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_right_titles.dart';

class PriceChartTitles {
  static getTitleData(context) => FlTitlesData(
        show: true,
        bottomTitles: PriceChartBottomTitles.getBottomTitles(context),
        rightTitles: PriceChartRightTitles.getRightTitles(context),
        leftTitles: SideTitles(showTitles: false)
      );
}