import 'package:galaxy_food/core/domain/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package_item.dart';

part 'package.g.dart';

@JsonSerializable()
class Package{
  late final String id;
  late final String name;
  late final List<int>? image;
  late final String? parent;
  late final String restaurant;
  late final List<Package> children;
  late final List<PackageItem> items;

  Package({
    required this.id,
    required this.name,
    this.image,
    required this.parent,
    required this.restaurant,
    this.children = const [],
    this.items = const []
  });

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Package && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}