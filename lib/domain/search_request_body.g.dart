// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequestBody _$SearchRequestBodyFromJson(Map<String, dynamic> json) {
  return SearchRequestBody()
    ..filters = (json['filters'] as List<dynamic>)
        .map((e) => SearchFilter.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SearchRequestBodyToJson(SearchRequestBody instance) =>
    <String, dynamic>{
      'filters': instance.filters,
    };
