import 'dart:async';
import 'dart:convert';

import 'package:natrium_wallet_flutter/model/available_currency.dart';
import 'package:http/http.dart' as http;
import 'package:natrium_wallet_flutter/model/chart.dart';
import 'package:natrium_wallet_flutter/network/model/response/error_response.dart';

const String _SERVER_ADDRESS_HTTP = "https://api.coingecko.com/api/v3/coins/nano/market_chart?";

class NanoHistoryService {
  Future<dynamic> fetchNanoHistory(AvailableCurrency currency, ChartHistoryButtonTypes historyType) async {
    String currencyParam = currency.getIso4217Code();
    String pastDaysParam; // eg. 1, 14, 30 or max
    String intervalParam; // minutely, hourly or daily

    switch (historyType) {
      case ChartHistoryButtonTypes.TODAY:
        pastDaysParam = "1";
        intervalParam = "hourly";
        break;
      case ChartHistoryButtonTypes.WEEK:
        pastDaysParam = "7";
        intervalParam = "daily";
        break;
      case ChartHistoryButtonTypes.MONTH:
        pastDaysParam = "30";
        intervalParam = "daily";
        break;
      case ChartHistoryButtonTypes.YEAR:
        pastDaysParam = "365";
        intervalParam = "daily";
        break;
      case ChartHistoryButtonTypes.MAX:
        pastDaysParam = "max";
        intervalParam = "daily";
        break;
      default:
        pastDaysParam = "1";
        intervalParam = "hourly";
    }

    String parameter = "vs_currency=$currencyParam&days=$pastDaysParam&interval=$intervalParam";

    http.Response response = await http.get(
      _SERVER_ADDRESS_HTTP + parameter
    );

    if (response.statusCode != 200) {
      return null;
    }

    Map decoded = json.decode(response.body);
    
    if (decoded.containsKey("error")) {
      return ErrorResponse.fromJson(decoded);
    }

    return decoded;
  }
}