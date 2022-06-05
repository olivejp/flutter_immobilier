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
        .toList();
}

Map<String, dynamic> _$FacetToJson(Facet instance) => <String, dynamic>{
      'name': instance.name,
      'field': instance.field,
      'buckets': instance.buckets,
    };
