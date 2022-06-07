// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce_immobiliere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annonce _$AnnonceFromJson(Map<String, dynamic> json) {
  return Annonce()
    ..id = json['id'] as String?
    ..description = json['description'] as String?
    ..quartier = json['quartier'] as String?
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..nomAgence = json['nomAgence'] as String?
    ..prix = (json['prix'] as num?)?.toDouble()
    ..categorie = json['categorie'] as String?
    ..type = json['type'] as String?
    ..transaction = json['transaction'] as String?
    ..superficie = (json['superficie'] as num?)?.toDouble()
    ..squareMeterPrice = json['squareMeterPrice'] as int?;
}

Map<String, dynamic> _$AnnonceToJson(Annonce instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'quartier': instance.quartier,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'nomAgence': instance.nomAgence,
      'prix': instance.prix,
      'categorie': instance.categorie,
      'type': instance.type,
      'transaction': instance.transaction,
      'superficie': instance.superficie,
      'squareMeterPrice': instance.squareMeterPrice,
    };
