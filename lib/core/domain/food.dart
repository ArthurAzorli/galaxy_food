import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package.dart';

part 'food.g.dart';

@JsonSerializable()
class Food extends PackageItem{
  Food({
    required super.id,
    required super.name,
    required super.price,
    super.image,
    required super.parent
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Food && other.id == id) return true;
    return false;
  }
}