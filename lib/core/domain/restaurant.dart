import 'package:galaxy_food/core/domain/address.dart';
import 'package:galaxy_food/core/domain/phone.dart';
import 'package:galaxy_food/core/domain/restaurant_owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant{
  late final String id;
  late final String cnpj;
  late final String email;
  late String name;
  late String? speciality;
  late List<int>? image;
  late Address address;
  late double score;
  late List<Phone> phones;
  late RestaurantOwner owner;

  Restaurant({
    required this.id,
    required this.cnpj,
    required this.email,
    required this.name,
    required this.speciality,
    this.image,
    required this.address,
    this.score = 0,
    required this.phones,
    required this.owner
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Phone && other.id == id) return true;
    return false;
  }
}