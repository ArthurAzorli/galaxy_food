import 'dart:convert';
import 'dart:typed_data';

extension BytesUtilsUintList on Uint8List{

  String get toUTF8 => utf8.decode(this);

}

extension BytesUtilsListInt on List<int>{

  Uint8List get toUint8List => Uint8List.fromList(this);
}