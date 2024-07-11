import 'package:json_annotation/json_annotation.dart';

part 'restaurant_owner.g.dart';

@JsonSerializable()
class RestaurantOwner {
  late final String id;
  late final String rg;
  late final String cpf;
  late final DateTime birthDate;
  late String name;

  RestaurantOwner({
    required this.id,
    required this.rg,
    required this.cpf,
    required this.birthDate,
    required this.name
  });

  factory RestaurantOwner.fromJson(Map<String, dynamic> json) => _$RestaurantOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantOwnerToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is RestaurantOwner && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;
}