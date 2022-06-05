import 'package:flutter_immobilier/domain/bucket_aggregation_model.dart';
import 'package:flutter_immobilier/domain/search_request_body.dart';
import 'package:json_annotation/json_annotation.dart';

import 'search_filter.dart';

part 'search_facet_body.g.dart';

@JsonSerializable()
class SearchFacetBody extends SearchRequestBody {
  List<BucketAggregationModel> listBucketModel = [];

  SearchFacetBody();

  factory SearchFacetBody.fromJson(Map<String, dynamic> data) =>
      _$SearchFacetBodyFromJson(data);

  Map<String, dynamic> toJson() => _$SearchFacetBodyToJson(this);
}
