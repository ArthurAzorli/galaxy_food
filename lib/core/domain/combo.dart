import 'package:galaxy_food/core/domain/food.dart';
import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'combo.g.dart';

@JsonSerializable()
class Combo extends PackageItem{

  late List<ComboItem> items;

  Combo({
    required super.id,
    required super.name,
    required super.price,
    required super.parent,
    this.items = const []
  });

  factory Combo.fromJson(Map<String, dynamic> json) => _$ComboFromJson(json);

  Map<String, dynamic> toJson() => _$ComboToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Combo && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;


}

@JsonSerializable()
class ComboItem {
  late final String id;
  late final int quantity;
  late final String combo;
  late final Food item;

  ComboItem({
    required this.id,
    required this.quantity,
    required this.combo,
    required this.item
  });

  factory ComboItem.fromJson(Map<String, dynamic> json) => _$ComboItemFromJson(json);

  Map<String, dynamic> toJson() => _$ComboItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is ComboItem && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}

extension ComboItems on  List<ComboItem>{
  String get ListToString{
    final buffer = StringBuffer();

    for (final item in this){
      buffer.write("${item.quantity}x ${item.item.name}\n");
    }

    return buffer.toString();
  }
}