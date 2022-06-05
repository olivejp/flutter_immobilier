// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_aggregation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BucketAggregationModel _$BucketAggregationModelFromJson(
    Map<String, dynamic> json) {
  return BucketAggregationModel()
    ..name = json['name'] as String?
    ..field = json['field'] as String?
    ..typeAggregation =
        _$enumDecodeNullable(_$TypeAggregationEnumMap, json['typeAggregation']);
}

Map<String, dynamic> _$BucketAggregationModelToJson(
        BucketAggregationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'field': instance.field,
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
