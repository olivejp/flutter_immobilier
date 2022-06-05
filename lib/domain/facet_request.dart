import 'package:json_annotation/json_annotation.dart';

import 'bucket.dart';

part 'facet_request.g.dart';

enum TypeAggregation {
  TERMS,
  MAX,
  RANGE
}

@JsonSerializable()
class FacetRequest {
  String? name;
  String? field;
  TypeAggregation? typeAggregation;

  FacetRequest();

  factory FacetRequest.fromJson(Map<String, dynamic> data) =>
      _$FacetRequestFromJson(data);


  Map<String, dynamic> toJson() => _$FacetRequestToJson(this);

}