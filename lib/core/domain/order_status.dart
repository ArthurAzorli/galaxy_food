import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum OrderStatus{
  canceled(0, Colors.red),
  waiting(1, Colors.orange),
  making(2, Colors.amber),
  made(3, Colors.blue),
  delivered(4, Colors.green);

  final int code;
  final Color color;
  const OrderStatus(this.code, this.color);

  static OrderStatus? getFromCode(int code){
    for (var status in OrderStatus.values){
      if (status.code == code) return status;
    }
    return null;
  }

  @override
  toString(){
    switch(code){
      case(0):
        return "Cancelado";
      case(1):
        return "Em espera";
      case(2):
        return "Preparando";
      case(3):
        return "Feito";
      case(4):
        return "Entregue";
      default:
        return "Erro";
    }
  }
}