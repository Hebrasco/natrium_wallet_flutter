// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nano_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NanoHistoryResponse _$NanoHistoryResponseFromJson(Map<String, dynamic> json) {
  return NanoHistoryResponse(
    prices: (json['prices'] as List)
        ?.map((e) => (e as List)?.map((e) => e as num)?.toList())
        ?.toList(),
    marketCaps: (json['market_caps'] as List)
        ?.map((e) => (e as List)?.map((e) => e as num)?.toList())
        ?.toList(),
    totalVolumes: (json['total_volumes'] as List)
        ?.map((e) => (e as List)?.map((e) => e as num)?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$NanoHistoryResponseToJson(
        NanoHistoryResponse instance) =>
    <String, dynamic>{
      'prices': instance.prices,
      'market_caps': instance.marketCaps,
      'total_volumes': instance.totalVolumes,
    };
