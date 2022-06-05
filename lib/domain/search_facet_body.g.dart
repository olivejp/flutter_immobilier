// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_facet_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFacetBody _$SearchFacetBodyFromJson(Map<String, dynamic> json) {
  return SearchFacetBody()
    ..filters = (json['filters'] as List<dynamic>)
        .map((e) => SearchFilter.fromJson(e as Map<String, dynamic>))
        .toList()
    ..listBucketModel = (json['listBucketModel'] as List<dynamic>)
        .map((e) => BucketAggregationModel.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SearchFacetBodyToJson(SearchFacetBody instance) =>
    <String, dynamic>{
      'filters': instance.filters,
      'listBucketModel': instance.listBucketModel,
    };
