import 'package:fl_chart/fl_chart.dart';
import 'package:natrium_wallet_flutter/ui/widgets/chart/chart_history_selection.dart';

enum ChartHistoryButtonTypes {
  TODAY,
  WEEK,
  MONTH,
  YEAR,
  MAX
}

class Chart {
  double minValue;
  double maxValue;
  double amountSteps;
  List<FlSpot> spots;
  ChartHistoryButtonTypes selectedHistoryButton;

  // Dummy data
  List<FlSpot> todaySpots = [
    FlSpot(0, 3.2),
    FlSpot(1, 2.1),
    FlSpot(2, 2.6),
    FlSpot(3, 2.5),
    FlSpot(5, 2.3),
    FlSpot(6, 2.0),
    FlSpot(7, 2.8),
    FlSpot(8, 2.6),
    FlSpot(9, 3.2),
    FlSpot(10, 2.8),
    FlSpot(11, 4),
  ];
  List<FlSpot> weekSpots = [
    FlSpot(0, 3),
    FlSpot(1, 2),
    FlSpot(2, 5),
    FlSpot(3, 2.5),
    FlSpot(5, 4),
    FlSpot(6, 3),
  ];
  List<FlSpot> monthSpots = [
    FlSpot(0, 1.2),
    FlSpot(1, 2),
    FlSpot(2, 1.4),
    FlSpot(3, 2.1),
    FlSpot(5, 2.6),
    FlSpot(6, 3),
    FlSpot(7, 2.2),
    FlSpot(8, 2.6),
    FlSpot(9, 3.2),
    FlSpot(10, 1.8),
    FlSpot(11, 4),
  ];
  List<FlSpot> yearSpots = [
    FlSpot(0, 0.5),
    FlSpot(1, 0.6),
    FlSpot(2, 1),
    FlSpot(3, 1.1),
    FlSpot(5, 1.4),
    FlSpot(6, 1.3),
    FlSpot(7, 1.7),
    FlSpot(8, 2.2),
    FlSpot(9, 2.9),
    FlSpot(10, 3),
    FlSpot(11, 3.2),
  ];
  List<FlSpot> maxSpots = [
    FlSpot(0, 0.1),
    FlSpot(1, 0.2),
    FlSpot(2, 0.2),
    FlSpot(3, 0.3),
    FlSpot(5, 0.4),
    FlSpot(6, 0.45),
    FlSpot(7, 0.5),
    FlSpot(8, 0.7),
    FlSpot(9, 1),
    FlSpot(10, 1.3),
    FlSpot(11, 1),
  ];

  Chart() {
    this.minValue = 0;
    this.maxValue = 10;
    this.amountSteps = 12;
    this.spots = todaySpots;
    this.selectedHistoryButton = ChartHistoryButtonTypes.TODAY;
  }

  void reload() {
    switch (selectedHistoryButton) {
      case ChartHistoryButtonTypes.TODAY:
        spots = todaySpots;
        break;
      case ChartHistoryButtonTypes.WEEK:
        spots = weekSpots;
        break;
      case ChartHistoryButtonTypes.MONTH:
        spots = monthSpots;
        break;
      case ChartHistoryButtonTypes.YEAR:
        spots = yearSpots;
        break;
      case ChartHistoryButtonTypes.MAX:
        spots = maxSpots;
        break;
    }
    reloadTitles();
  }

  void reloadTitles() {
    double valueOffset = 1;
    amountSteps = spots.length.toDouble();
    minValue = spots.first.y;
    maxValue = spots.last.y;

    spots.forEach((spot) {
      if (spot.y > maxValue) maxValue = spot.y + valueOffset;
      if (spot.y < minValue) minValue = spot.y - valueOffset;
    });
  }
}