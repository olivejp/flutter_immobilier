// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageable<T> _$PageableFromJson<T>(Map<String, dynamic> json) {
  return Pageable<T>()
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..offset = json['offset'] as int?
    ..pageNumber = json['pageNumber'] as int?
    ..pageSize = json['pageSize'] as int?
    ..paged = json['paged'] as bool?
    ..unpaged = json['unpaged'] as bool?;
}

Map<String, dynamic> _$PageableToJson<T>(Pageable<T> instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'offset': instance.offset,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };
