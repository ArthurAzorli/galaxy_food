
import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone{
  final String? id;
  final String phone;

  const Phone({
    this.id,
    required this.phone
  });

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Phone && other.id == id) return true;
    return false;
  }
}