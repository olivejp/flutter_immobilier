import 'package:flutter_immobilier/deveoLibrary/abstract.domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'annonce_immobiliere.g.dart';

@JsonSerializable()
class Annonce extends AbstractDomain<String> {
  Annonce();

  factory Annonce.fromJson(Map<String, dynamic> data) =>
      _$AnnonceFromJson(data);

  String? description;
  String? quartier;
  double? latitude;
  double? longitude;
  String? nomAgence;
  double? prix;
  String? categorie;
  String? type;
  String? transaction;
  double? superficie;
  int? squareMeterPrice;

  @override
  Map<String, dynamic> toJson() => _$AnnonceToJson(this);

  @override
  Annonce fromJson(Map<String, dynamic> map) {
    return Annonce.fromJson(map);
  }

  @override
  String getId() {
    return id ?? 'UNKNOWN';
  }
}
