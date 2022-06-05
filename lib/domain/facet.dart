import 'package:json_annotation/json_annotation.dart';

import '../domain/bucket.dart';
import 'facet_request.dart';

part 'facet.g.dart';

@JsonSerializable()
class Facet {
  String? name;
  String? field;
  List<Bucket>? buckets;
  double? value;
  TypeAggregation? typeAggregation;

  Facet();

  factory Facet.fromJson(Map<String, dynamic> data) =>
      _$FacetFromJson(data);
}