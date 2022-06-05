import 'package:json_annotation/json_annotation.dart';

import 'bucket.dart';

part 'facet.g.dart';

@JsonSerializable()
class Facet {
  String? name;
  String? field;
  List<Bucket>? buckets;

  Facet();

  factory Facet.fromJson(Map<String, dynamic> data) =>
      _$FacetFromJson(data);
}