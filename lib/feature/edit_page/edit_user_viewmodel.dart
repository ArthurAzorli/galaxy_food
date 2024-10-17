import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/buy_repository_service.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:galaxy_food/core/widgets/image_picker.dart';
import 'package:galaxy_food/feature/main_page/main_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/client.dart';
import '../../core/service/repository/client_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';

part 'edit_user_viewmodel.g.dart';

class EditUserViewModel = EditUserViewModelBase with _$EditUserViewModel;

abstract class EditUserViewModelBase with Store{

  EditUserViewModelBase(BuildContext context){
    _getClient(context);
  }

  final formKey = GlobalKey<FormState>();

  void _getClient(BuildContext context) async {
    try {
      client = await ClientRepositoryService.getUser();

      if (client != null) {
        userImage = client!.image != null
            ? Image.memory(client!.image!.toUint8List).image
            : Image.asset("lib/images/user_default.png").image;

        nameEditingController.text = client!.name;
        emailEditingController.text = client!.email;
      }
    } on RepositoryException catch (e) {
      e.showMessageDialog(context, () => Navigator.of(context).pop());
    }
  }

  @observable
  Client? client;

  @observable
  ImageProvider? userImage;

  @observable
  Uint8List? imageData;

  @observable
  var nameFocus = FocusNode();

  @observable
  var nameEditingController = TextEditingController();

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController();

  @action
  changeImage(ImagePickerSource source) async{
    var image = await ImagePicker.getImage(
      aspectX: 1,
      aspectY: 1,
      source
    );

    if (image !=  null) {
      userImage = Image.memory(image).image;
      imageData = image;
    }

  }

  @action
  String? nameValidator(String? name){
    if (name == null || name.isEmpty) return 'Campo do Nome vazio!';
    return null;
  }

  @action
  String? emailValidator(String? email){
    if (email == null || email.isEmpty) return 'Campo do E-mail vazio!';
    return null;
  }

  @action
  update(BuildContext context) async{
    if (formKey.currentState!.validate()) {

      client!.name = nameEditingController.text;
      client!.email = emailEditingController.text;
      client!.image = imageData;

      try{
        await ClientRepositoryService.update(client!);
        context.go("/");
        GetIt.I.get<MainViewModel>().pageController.animateToPage(
            3,
            duration: kThemeChangeDuration,
            curve: Curves.linear
        );

      } on RepositoryException catch(e) {

        e.showMessageDialog(context, ()=>Navigator.of(context).pop(), title: "ao fazer a Edição");

      }
    }
  }

  @action
  cancel(BuildContext context){
    context.go("/");
    GetIt.I.get<MainViewModel>().pageController.animateToPage(
        3,
        duration: kThemeChangeDuration,
        curve: Curves.linear
    );
  }


}

