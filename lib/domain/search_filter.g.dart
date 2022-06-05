// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFilter _$SearchFilterFromJson(Map<String, dynamic> json) {
  return SearchFilter(
    field: json['field'] as String?,
    type: json['type'] as String?,
    value: json['value'] as String?,
  );
}

Map<String, dynamic> _$SearchFilterToJson(SearchFilter instance) =>
    <String, dynamic>{
      'field': instance.field,
      'type': instance.type,
      'value': instance.value,
    };
