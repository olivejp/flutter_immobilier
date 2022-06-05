// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T>(Map<String, dynamic> json) {
  return Page<T>()
    ..last = json['last'] as bool?
    ..totalPages = json['totalPages'] as int?
    ..totalElements = json['totalElements'] as int?
    ..first = json['first'] as bool?
    ..number = json['number'] as int?
    ..size = json['size'] as int?
    ..numberOfElements = json['numberOfElements'] as int?
    ..empty = json['empty'] as bool?
    ..content = (json['content'] as List<dynamic>?)
        ?.map(_Converter<T>().fromJson)
        .toList()
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..pageable = json['pageable'] == null
        ? null
        : Pageable.fromJson(json['pageable'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PageToJson<T>(Page<T> instance) => <String, dynamic>{
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'number': instance.number,
      'size': instance.size,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
      'content': instance.content?.map(_Converter<T>().toJson).toList(),
      'sort': instance.sort,
      'pageable': instance.pageable,
    };
