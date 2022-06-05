// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sort<T> _$SortFromJson<T>(Map<String, dynamic> json) {
  return Sort<T>()
    ..empty = json['empty'] as bool?
    ..unsorted = json['unsorted'] as bool?
    ..sorted = json['sorted'] as bool?;
}

Map<String, dynamic> _$SortToJson<T>(Sort<T> instance) => <String, dynamic>{
      'empty': instance.empty,
      'unsorted': instance.unsorted,
      'sorted': instance.sorted,
    };
