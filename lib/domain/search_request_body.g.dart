// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBodyRequest _$SearchBodyRequestFromJson(Map<String, dynamic> json) {
  return SearchBodyRequest()
    ..filters = (json['filters'] as List<dynamic>?)
        ?.map((e) => SearchFilter.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SearchBodyRequestToJson(SearchBodyRequest instance) =>
    <String, dynamic>{
      'filters': instance.filters,
    };
