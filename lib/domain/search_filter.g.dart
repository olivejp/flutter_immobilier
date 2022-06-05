// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFilter _$SearchFilterFromJson(Map<String, dynamic> json) {
  return SearchFilter(
    field: json['field'] as String?,
    type: _$enumDecodeNullable(_$TypeSearchFilterEnumMap, json['type']),
    value: json['value'] as String?,
  );
}

Map<String, dynamic> _$SearchFilterToJson(SearchFilter instance) =>
    <String, dynamic>{
      'field': instance.field,
      'type': _$TypeSearchFilterEnumMap[instance.type],
      'value': instance.value,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$TypeSearchFilterEnumMap = {
  TypeSearchFilter.MATCH: 'MATCH',
};
