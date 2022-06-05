import 'package:json_annotation/json_annotation.dart';

import 'bucket.dart';

part 'bucket_aggregation_model.g.dart';

enum TypeAggregation {
  TERMS,
  MAX,
  RANGE
}

@JsonSerializable()
class BucketAggregationModel {
  String? name;
  String? field;
  TypeAggregation? typeAggregation;

  BucketAggregationModel();

  factory BucketAggregationModel.fromJson(Map<String, dynamic> data) =>
      _$BucketAggregationModelFromJson(data);


  Map<String, dynamic> toJson() => _$BucketAggregationModelToJson(this);

}