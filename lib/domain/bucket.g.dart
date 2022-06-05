// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bucket _$BucketFromJson(Map<String, dynamic> json) {
  return Bucket()
    ..name = json['name'] as String?
    ..docCount = json['docCount'] as int?;
}

Map<String, dynamic> _$BucketToJson(Bucket instance) => <String, dynamic>{
      'name': instance.name,
      'docCount': instance.docCount,
    };
