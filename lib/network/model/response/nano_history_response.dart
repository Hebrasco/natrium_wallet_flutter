import 'package:json_annotation/json_annotation.dart';

part 'nano_history_response.g.dart';

/// For running in an isolate, needs to be top-level function
NanoHistoryResponse accountHistoryresponseFromJson(Map<dynamic, dynamic> json) {
  return NanoHistoryResponse.fromJson(json);
} 

@JsonSerializable()
class NanoHistoryResponse {
  @JsonKey(name:'prices')
  List<List<num>> prices;
  @JsonKey(name:'market_caps')
  List<List<num>> marketCaps;

  @JsonKey(name:'total_volumes')
  List<List<num>> totalVolumes;

  NanoHistoryResponse({List<List<num>> prices, List<List<num>> marketCaps, List<List<num>> totalVolumes}) {
    this.prices = prices;
    this.marketCaps = marketCaps;
    this.totalVolumes = totalVolumes;
  }

  factory NanoHistoryResponse.fromJson(Map<String, dynamic> json) => _$NanoHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NanoHistoryResponseToJson(this);
}