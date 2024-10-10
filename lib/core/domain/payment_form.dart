import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PaymentForm{
  dinheiro(0),
  credito(1),
  debito(2),
  pix(3);

  final int code;
  const PaymentForm(this.code);

  static PaymentForm? getFromCode(int code){
    for (var form in PaymentForm.values){
      if (form.code == code) return form;
    }
    return null;
  }

  @override
  String toString(){
    switch(code){
      case(0):
        return "Dinheiro";
      case(1):
        return "Crétido";
      case(2):
        return "Débito";
      case(3):
        return "PIX";
      default:
        return "Erro";
    }
  }

}