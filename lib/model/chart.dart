import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:natrium_wallet_flutter/model/available_currency.dart';
import 'package:natrium_wallet_flutter/network/model/response/nano_history_response.dart';
import 'package:natrium_wallet_flutter/network/nano_history_service.dart';

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
  ];
  List<FlSpot> weekSpots = [
    FlSpot(0, 3),
    FlSpot(1, 2),
    FlSpot(2, 5),
    FlSpot(3, 2.5),
    FlSpot(5, 3.3),
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
    FlSpot(4, 1.2),
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

  Chart(AvailableCurrency currency) {
    this.selectedHistoryButton = ChartHistoryButtonTypes.TODAY;
    loadHistoryData(currency);
    reload();
  }

  void loadHistoryData(AvailableCurrency currency) {
    fetchHistoryData(currency, ChartHistoryButtonTypes.TODAY);
    fetchHistoryData(currency, ChartHistoryButtonTypes.WEEK);
    fetchHistoryData(currency, ChartHistoryButtonTypes.MONTH);
    fetchHistoryData(currency, ChartHistoryButtonTypes.YEAR);
    fetchHistoryData(currency, ChartHistoryButtonTypes.MAX);

    reload();
  }

  Future<void> fetchHistoryData(AvailableCurrency currency, ChartHistoryButtonTypes historyType) async {
      NanoHistoryService().fetchNanoHistory(currency, historyType).then((response) {
        print("res: " + response.toString());
        NanoHistoryResponse historyResponse = NanoHistoryResponse.fromJson(response);
        fillValues(historyResponse, historyType);
      });
    
  }

  void fillValues(NanoHistoryResponse response, ChartHistoryButtonTypes historyType) {
    List<FlSpot> newSpots = [];
    response.prices.forEach((priceList) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(priceList.first.toInt());
      print(historyType.toString() + " Time: " + time.toString());

      double spotIndex = response.prices.indexOf(priceList).toDouble();
      FlSpot spot = FlSpot(spotIndex, priceList.last);

      newSpots.add(spot);
    });

    switch (selectedHistoryButton) {
      case ChartHistoryButtonTypes.TODAY:
        todaySpots = newSpots;
        break;
      case ChartHistoryButtonTypes.WEEK:
        weekSpots = newSpots;
        break;
      case ChartHistoryButtonTypes.MONTH:
        monthSpots = newSpots;
        break;
      case ChartHistoryButtonTypes.YEAR:
        yearSpots = newSpots;
        break;
      case ChartHistoryButtonTypes.MAX:
        maxSpots = newSpots;
        break;
      default:
    }
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
    double valueOffset = 0.5;
    double zeroPoint = 0;

    minAmountSteps = spots.first.x;
    maxAmountSteps = spots.last.x;
    minValue = spots.first.y;
    maxValue = spots.first.y;

    spots.forEach((spot) {
      if (spot.y >= maxValue) maxValue = spot.y;
      if (spot.y <= minValue) minValue = spot.y;
    });

    double newMinValue = minValue - valueOffset;
    if (newMinValue < zeroPoint) {
      minValue = zeroPoint;
    } else {
      minValue = newMinValue;
    }
    maxValue += valueOffset;
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
        return "missing";
    }
  }

  String parseTodayTitle(double titleSpot) {
    if (titleSpot % 3 == 0 && titleSpot != spots.first.x) {
      return spots[titleSpot.toInt()].x.toInt().toString() + ":00";
    } else {
      return "";
    }
  }

  String parseWeekTitle(double titleSpot)  {
    switch (titleSpot.toInt()) {
      case 1:
        return "TUE";
      case 2:
        return "WED";
      case 3:
        return "THU";
      case 4:
        return "FRI";
      case 5:
        return "SAT";
      case 6:
        return "SUN";
      default:
        return "";
    }
  }

  String parseMonthTitle(double titleSpot)  {
    if (titleSpot.toInt() % 3 == 0 && titleSpot != spots.first.x) {
      return titleSpot.toInt().toString() + ".";
    } else {
      return "";
    }
  }

  String parseYearTitle(double titleSpot)  {
    switch (titleSpot.toInt()) {
      case 1: 
        return "FEB";
      case 3:
        return "APR";
      case 5:
        return "JUN";
      case 7:
        return "AUG";
      case 9:
        return "OCT";
      case 11:
        return "DEC";
      default:
        return "";
    }
  }

  String parseMaxTitle(double titlespot) {
    return ""; // TODO: create title
  }
}