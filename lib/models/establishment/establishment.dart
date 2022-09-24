import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'establishment.g.dart';

@JsonSerializable()
class Establishment extends Equatable {
  int id;
  String thumb;
  String tradeName;
  String fantasy;
  String address;
  String? complement;
  String district;
  String city;
  String state;
  double rating;
  double? distance;
  bool barpassPay;

  Establishment({
    required this.id,
    required this.thumb,
    required this.tradeName,
    required this.fantasy,
    required this.address,
    this.complement,
    required this.district,
    required this.city,
    required this.state,
    required this.rating,
    this.distance,
    required this.barpassPay,
  });

  @override
  List<Object?> get props => [
        id,
        thumb,
        tradeName,
        fantasy,
        address,
        complement,
        district,
        city,
        state,
        rating,
        distance,
        barpassPay,
      ];
}
