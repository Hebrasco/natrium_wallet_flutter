import 'dart:async';
import 'dart:convert';

import 'package:natrium_wallet_flutter/model/available_currency.dart';
import 'package:http/http.dart' as http;
import 'package:natrium_wallet_flutter/network/model/response/error_response.dart';

const String _SERVER_ADDRESS_HTTP = "https://api.coingecko.com/api/v3/coins/nano/market_chart?";

class NanoHistoryService {
  Future<dynamic> fetchNanoHistory(AvailableCurrency currency) async {
    String currencyParam = currency.getIso4217Code();
    String pastDaysParam = "7";
    String intervalParam = "daily";

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