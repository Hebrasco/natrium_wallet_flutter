import 'dart:async';
import 'package:natrium_wallet_flutter/model/available_currency.dart';
import 'package:natrium_wallet_flutter/model/chart_spot.dart';
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
  List<ChartSpot> spots;
  ChartHistoryButtonTypes selectedHistoryButton;

  List<ChartSpot> todaySpots;
  List<ChartSpot> weekSpots;
  List<ChartSpot> monthSpots;
  List<ChartSpot> yearSpots;
  List<ChartSpot> maxSpots;

  Chart(AvailableCurrency currency) {
    this.selectedHistoryButton = ChartHistoryButtonTypes.TODAY;

    // FlSChart needs inital spots - cannot be null or empty
    List<ChartSpot> initialSpots = [ChartSpot(DateTime.now(), 0, 0), ChartSpot(DateTime.now(), 0, 0)];
    spots = initialSpots;
    todaySpots = spots;
    weekSpots = spots;
    monthSpots = spots;
    yearSpots = spots;
    maxSpots = spots;

    loadHistoryData(currency);
  }

  void loadHistoryData(AvailableCurrency currency) {
    fetchHistoryData(currency, ChartHistoryButtonTypes.TODAY);
    fetchHistoryData(currency, ChartHistoryButtonTypes.WEEK);
    fetchHistoryData(currency, ChartHistoryButtonTypes.MONTH);
    fetchHistoryData(currency, ChartHistoryButtonTypes.YEAR);
    fetchHistoryData(currency, ChartHistoryButtonTypes.MAX);
  }

  Future<void> fetchHistoryData(AvailableCurrency currency, ChartHistoryButtonTypes historyType) async {
      NanoHistoryService().fetchNanoHistory(currency, historyType).then((response) {
        NanoHistoryResponse historyResponse = NanoHistoryResponse.fromJson(response);
        fillValues(historyResponse, historyType);
      });
    
  }

  void fillValues(NanoHistoryResponse response, ChartHistoryButtonTypes historyType) {
    List<ChartSpot> newSpots = [];
    response.prices.forEach((priceList) {
      DateTime spotDate = DateTime.fromMillisecondsSinceEpoch(priceList.first.toInt());
      double spotIndex = response.prices.indexOf(priceList).toDouble();
      double spotValue = priceList.last;
      ChartSpot spot = ChartSpot(spotDate, spotIndex, spotValue);

      newSpots.add(spot);
    });

    newSpots = filterValues(newSpots, historyType);

    print(historyType.toString() + ", Filtered spots range: 0.." + (newSpots.length - 1).toString());

    switch (historyType) {
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

    reload();
  }


  List<ChartSpot> filterValues(List<ChartSpot> spots, ChartHistoryButtonTypes historyType) {
    return spots.where((spot) {
      // print(historyType.toString() + ", Time: " + spot.dateTime.toString() + ", Price: " + spot.y.toStringAsFixed(2));
      
      switch (historyType) {
        case ChartHistoryButtonTypes.TODAY:
          // Every 10 mins
          return spots.indexOf(spot) % 2 == 0;
        case ChartHistoryButtonTypes.WEEK:
          // Every 60 mins
          return true;
        case ChartHistoryButtonTypes.MONTH:
          // Every 4 hours
          return spots.indexOf(spot) % 4 == 0;
        case ChartHistoryButtonTypes.YEAR:
          // Every 2 day
          return spots.indexOf(spot) % 2 == 0;
        case ChartHistoryButtonTypes.MAX:
          // Every 4 days
          bool spotDateIsEven;
          bool isTodayEven = DateTime.now().day % 2 == 0;

          if (isTodayEven) {
            
            spotDateIsEven = spot.dateTime.day % 4 == 0;
          } else {
            spotDateIsEven = (spot.dateTime.day - 1) % 4 == 0;
          }

          return spotDateIsEven;
        default:
          return true;
      }
    }).toList();
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