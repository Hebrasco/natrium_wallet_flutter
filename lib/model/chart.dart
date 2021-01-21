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
  double minAmountSteps;
  double maxAmountSteps;
  List<FlSpot> spots;
  ChartHistoryButtonTypes selectedHistoryButton;

  // Dummy data
  List<FlSpot> todaySpots = [
    FlSpot(0, 3),
    FlSpot(1, 3.3),
    FlSpot(2, 3.3),
    FlSpot(3, 3.4),
    FlSpot(4, 3.5),
    FlSpot(5, 3.4),
    FlSpot(6, 3.3),
    FlSpot(7, 3.1),
    FlSpot(8, 3.2),
    FlSpot(9, 2.1),
    FlSpot(10, 2.6),
    FlSpot(11, 2.5),
    FlSpot(12, 2.3),
    FlSpot(13, 2.0),
    FlSpot(14, 2.8),
    FlSpot(15, 2.6),
    FlSpot(16, 3.2),
    FlSpot(17, 2.8),
    FlSpot(18, 2.9),
    FlSpot(19, 3.1),
    FlSpot(20, 3.5),
    FlSpot(21, 2.1),
    FlSpot(22, 2.5),
    FlSpot(23, 2.6),
    FlSpot(24, 2.7),
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
    FlSpot(12, 1.2),
    FlSpot(13, 2),
    FlSpot(14, 1.4),
    FlSpot(15, 2.1),
    FlSpot(16, 2.6),
    FlSpot(17, 3),
    FlSpot(18, 2.2),
    FlSpot(19, 2.6),
    FlSpot(20, 3.2),
    FlSpot(21, 1.8),
    FlSpot(22, 4),
    FlSpot(23, 1.2),
    FlSpot(24, 2),
    FlSpot(25, 1.4),
    FlSpot(26, 2.1),
    FlSpot(27, 2.6),
    FlSpot(28, 3),
    FlSpot(29, 2.2),
    FlSpot(30, 2.6),
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
    this.minAmountSteps = 0;
    this.maxAmountSteps = 12;
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

    minAmountSteps = spots.first.x;
    maxAmountSteps = spots.last.x;
    minValue = spots.first.y;
    maxValue = spots.last.y;

    spots.forEach((spot) {
      if (spot.y > maxValue) maxValue = spot.y + valueOffset;
      if (spot.y < minValue) minValue = spot.y - valueOffset;
    });
  }

  String getBottomTitles(double titleSpot) {
    switch (selectedHistoryButton) {
      case ChartHistoryButtonTypes.TODAY:
        return parseTodayTitle(titleSpot);
      case ChartHistoryButtonTypes.WEEK:
        return parseWeekTitle(titleSpot);
      case ChartHistoryButtonTypes.MONTH:
        return parseMonthTitle(titleSpot);
      case ChartHistoryButtonTypes.YEAR:
        return parseYearTitle(titleSpot);
      case ChartHistoryButtonTypes.MAX:
        return parseMaxTitle(titleSpot);
      default:
    }
  }

  String parseTodayTitle(double titleSpot) {
    if (titleSpot % 3 == 0 && titleSpot != spots.first.x && titleSpot != spots.last.x) {
      return spots[titleSpot.toInt()].x.toInt().toString() + ":00";
    } else {
      return "";
    }
  }

  String parseWeekTitle(double titleSpot)  {
    switch (titleSpot.toInt()) {
      case 1: 
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WED";
      case 4:
        return "THU";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      case 7:
        return "SUN";
    }
    return "";
  }

  String parseMonthTitle(double titleSpot)  {
    if (titleSpot.toInt() % 3 == 0 && titleSpot != spots.first.x && titleSpot != spots.last.x) {
      return titleSpot.toInt().toString() + ".";
    } else {
      return "";
    }
  }

  String parseYearTitle(double titleSpot)  {
    switch (titleSpot.toInt()) {
      case 1: 
        return "JAN";
      case 3:
        return "MAR";
      case 5:
        return "MAY";
      case 7:
        return "JUL";
      case 9:
        return "SEP";
      case 11:
        return "NOV";
    }
    return "";
  }

  String parseMaxTitle(double titlespot) {
    return ""; // TODO: create title
  }
}