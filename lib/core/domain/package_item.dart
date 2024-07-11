import 'package:galaxy_food/core/domain/package.dart';
import 'package:json_annotation/json_annotation.dart';

import 'combo.dart';
import 'food.dart';

part 'package_item.g.dart';

@JsonSerializable()
abstract class PackageItem{
  late final String id;
  late final String name;
  late final double price;
  late final List<int> image;
  late final String parent;

  PackageItem({
    required this.id,
    required this.name,
    required this.price,
    this.image = const [],
    required Package parent
  }): parent = parent.id;

  static PackageItem fromJson(Map<String, dynamic> json){
    if (json["items"] != null){
      return Combo.fromJson(json);
    } else {
      return Food.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$PackageItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is PackageItem && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}