import 'package:brasil_fields/brasil_fields.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address{

  late final String? id;
  late final String street;
  late final String number;
  late final String neighborhood;
  late final String city;
  late final String state;
  late final String cep;

  Address({
    required this.id,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required String cep
  })
      : assert(Estados.listaEstadosSigla.contains(state)),
      cep = UtilBrasilFields.obterCep(cep, ponto: false);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Address && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}