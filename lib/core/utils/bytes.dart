import 'dart:convert';
import 'dart:typed_data';

extension BytesUtils on Uint8List{

  String get toUTF8 => utf8.decode(this);

}