import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'phone.dart';

part 'client.g.dart';

@JsonSerializable()
class Client{
  late final String id;
  late final String cpf;
  late String name;
  late String email;
  late final DateTime birthDate;
  late List<int>? image;
  late final List<Address> addresses;
  late final List<Phone> phones;

  @JsonKey(includeFromJson: false, includeToJson: true, name: "password")
  String? _password;

  Client({
    required this.id,
    required this.cpf,
    required this.name,
    required this.email,
    required this.birthDate,
    this.image,
    this.addresses = const [],
    this.phones = const []
  });

  set password(String password) => _password = password;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Client && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;
}