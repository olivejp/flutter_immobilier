// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Facet _$FacetFromJson(Map<String, dynamic> json) {
  return Facet()
    ..name = json['name'] as String?
    ..field = json['field'] as String?
    ..buckets = (json['buckets'] as List<dynamic>?)
        ?.map((e) => Bucket.fromJson(e as Map<String, dynamic>))
        .toList()
    ..value = (json['value'] as num?)?.toDouble()
    ..typeAggregation =
        _$enumDecodeNullable(_$TypeAggregationEnumMap, json['typeAggregation']);
}

Map<String, dynamic> _$FacetToJson(Facet instance) => <String, dynamic>{
      'name': instance.name,
      'field': instance.field,
      'buckets': instance.buckets,
      'value': instance.value,
      'typeAggregation': _$TypeAggregationEnumMap[instance.typeAggregation],
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

const _$TypeAggregationEnumMap = {
  TypeAggregation.TERMS: 'TERMS',
  TypeAggregation.MAX: 'MAX',
  TypeAggregation.RANGE: 'RANGE',
};
