// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Establishment _$EstablishmentFromJson(Map<String, dynamic> json) {
  return Establishment(
    id: json['id'] as int,
    thumb: json['thumb'] as String,
    tradeName: json['tradeName'] as String,
    fantasy: json['fantasy'] as String,
    address: json['address'] as String,
    complement: json['complement'] as String?,
    district: json['district'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    rating: (json['rating'] as num).toDouble(),
    distance: (json['distance'] as num?)?.toDouble(),
    barpassPay: json['barpassPay'] as bool,
  );
}

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumb': instance.thumb,
      'tradeName': instance.tradeName,
      'fantasy': instance.fantasy,
      'address': instance.address,
      'complement': instance.complement,
      'district': instance.district,
      'city': instance.city,
      'state': instance.state,
      'rating': instance.rating,
      'distance': instance.distance,
      'barpassPay': instance.barpassPay,
    };
