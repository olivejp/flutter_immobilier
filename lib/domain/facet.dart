import 'package:json_annotation/json_annotation.dart';

import '../domain/bucket.dart';
import 'bucket_aggregation_model.dart';

part 'facet.g.dart';

@JsonSerializable()
class Facet {
  String? name;
  String? field;
  List<Bucket>? buckets;
  dynamic value;
  TypeAggregation? typeAggregation;

  Facet();

  factory Facet.fromJson(Map<String, dynamic> data) =>
      _$FacetFromJson(data);
}