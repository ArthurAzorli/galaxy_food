import 'package:flutter/services.dart';

enum ImagePickerSource{gallery, camera}

class ImagePicker {
  static const _platform = MethodChannel("galaxy_food.native.widget/image_picker");

  static Future<Uint8List?> getImage(ImagePickerSource source, {int? aspectX, int? aspectY, double? height, double? width}) async {

    assert((aspectX != null && aspectY != null) || (aspectX == null && aspectY == null));

    var data = {
      "aspectX": aspectX,
      "aspectY": aspectY,
      "height": height,
      "width": width
    };

    switch(source){
      case ImagePickerSource.gallery:
        return await _platform.invokeMethod<Uint8List>("getFromGallery", data);
      case ImagePickerSource.camera:
        return await _platform.invokeMethod<Uint8List>("getFromCamera", data);
    }

  }

  static Future<Uint8List?> getProvider() async{
    return await _platform.invokeMethod<Uint8List>("getProvider");
  }
}