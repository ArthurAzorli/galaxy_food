import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum OrderStatus{
  canceled(0),
  waiting(1),
  making(2),
  made(3),
  delivered(4);

  final int code;
  const OrderStatus(this.code);

  static OrderStatus? getFromCode(int code){
    for (var status in OrderStatus.values){
      if (status.code == code) return status;
    }
    return null;
  }
}