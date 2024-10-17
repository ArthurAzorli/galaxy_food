import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/widgets/image_picker.dart';
import 'package:galaxy_food/feature/edit_page/edit_user_viewmodel.dart';

import '../../core/widgets/galaxy_button.dart';

class EditUserPage extends StatefulWidget{

  const EditUserPage({super.key});

  @override
  State<StatefulWidget> createState() => _EditUserPageState();

}

class _EditUserPageState extends State<EditUserPage>{

  late final EditUserViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = EditUserViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1
      ),
    );

    final textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5
      ),
    );

    final textFieldErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5
        )
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  "lib/images/galaxyfood_logo.png",
                  height: 80,
                  color: theme.colorScheme.secondary,
                ),
              ),


              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 5),
                      child: Text(
                        "EDITAR USUÁRIO",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 5),
                        child: Observer(
                            builder: (context) {
                              return Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: theme.colorScheme.onSurface,
                                    image: viewModel.userImage == null? null : DecorationImage(
                                        image: viewModel.userImage!,
                                        fit: BoxFit.cover
                                    )
                                ),
                              );
                            }
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                        width: 225,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GalaxyButton(
                              style: const ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(100, 100)),
                              ),
                              onPressed: () async => await viewModel.changeImage(ImagePickerSource.camera),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: theme.colorScheme.secondary,
                                size: 35,
                              ),
                            ),

                            GalaxyButton(
                              style: const ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(100, 100)),
                              ),
                              onPressed: () async => await viewModel.changeImage(ImagePickerSource.gallery),
                              child: Icon(
                                Icons.image_outlined,
                                color: theme.colorScheme.secondary,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 5),
                      child: TextFormField(
                        cursorColor: theme.colorScheme.secondary,
                        cursorErrorColor: theme.colorScheme.secondary,
                        focusNode: viewModel.nameFocus,
                        controller: viewModel.nameEditingController,
                        keyboardType: TextInputType.text,
                        validator: viewModel.nameValidator,
                        decoration: InputDecoration(
                          labelStyle: theme.textTheme.bodyMedium,
                          labelText: "Nome",
                          border: textFieldBorder,
                          errorBorder: textFieldErrorBorder,
                          focusedBorder: textFieldFocusedBorder,
                          errorStyle: TextStyle(color: theme.colorScheme.onError),
                        ),
                        onTapOutside: (_) => viewModel.nameFocus.unfocus(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 5),
                      child: Observer(
                          builder: (context) {
                            return TextFormField(
                              cursorColor: theme.colorScheme.secondary,
                              cursorErrorColor: theme.colorScheme.secondary,
                              focusNode: viewModel.emailFocus,
                              controller: viewModel.emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: viewModel.emailValidator,
                              decoration: InputDecoration(
                                labelStyle: theme.textTheme.bodyMedium,
                                labelText: "E-mail",
                                border: textFieldBorder,
                                errorBorder: textFieldErrorBorder,
                                focusedBorder: textFieldFocusedBorder,
                                errorStyle: TextStyle(color: theme.colorScheme.onError),
                              ),
                              onTapOutside: (_) => viewModel.emailFocus.unfocus(),
                            );
                          }
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 65, bottom: 10),
                      child: GalaxyButton(
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        onPressed: () async => await viewModel.update(context),
                        child: const Text("SALVAR"),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GalaxyButton(
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        onPressed: () => viewModel.cancel(context),
                        child: const Text("CANCELAR"),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}