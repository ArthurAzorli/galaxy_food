import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/signup_page/signup_viewmodel.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => SignUpPageState();

}

class SignUpPageState extends State<SignUpPage>{
  final viewModel = SignUpViewModel();

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
                        "CADASTRE-SE",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 5),
                      child: TextFormField(
                        cursorColor: theme.colorScheme.secondary,
                        cursorErrorColor: theme.colorScheme.secondary,
                        focusNode: viewModel.cpfFocus,
                        controller: viewModel.cpfEditingController,
                        keyboardType: TextInputType.number,
                        validator: viewModel.cpfValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          labelStyle: theme.textTheme.bodyMedium,
                          labelText: "CPF",
                          border: textFieldBorder,
                          errorBorder: textFieldErrorBorder,
                          focusedBorder: textFieldFocusedBorder,
                          errorStyle: TextStyle(color: theme.colorScheme.onError),
                        ),
                        onTapOutside: (_) => viewModel.cpfFocus.unfocus(),
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
                      padding: const EdgeInsets.only(top: 30, bottom: 5),
                      child: TextFormField(
                        cursorColor: theme.colorScheme.secondary,
                        cursorErrorColor: theme.colorScheme.secondary,
                        focusNode: viewModel.birthDateFocus,
                        controller: viewModel.birthDateEditingController,
                        keyboardType: TextInputType.datetime,
                        validator: viewModel.birthDateValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter()
                        ],
                        decoration: InputDecoration(
                          labelStyle: theme.textTheme.bodyMedium,
                          labelText: "Data de Nascimento",
                          border: textFieldBorder,
                          errorBorder: textFieldErrorBorder,
                          focusedBorder: textFieldFocusedBorder,
                          errorStyle: TextStyle(color: theme.colorScheme.onError),
                        ),
                        onTapOutside: (_) => viewModel.birthDateFocus.unfocus(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Observer(
                          builder: (context) {
                            return TextFormField(
                              cursorColor: theme.colorScheme.secondary,
                              cursorErrorColor: theme.colorScheme.secondary,
                              focusNode: viewModel.passwordFocus,
                              controller: viewModel.passwordEditingController,
                              obscureText: !viewModel.seePassword,
                              validator: viewModel.passwordValidator,
                              decoration: InputDecoration(
                                  labelStyle: theme.textTheme.bodyMedium,
                                  labelText: "Senha",
                                  border: textFieldBorder,
                                  errorBorder: textFieldErrorBorder,
                                  focusedBorder: textFieldFocusedBorder,
                                  errorStyle: TextStyle(color: theme.colorScheme.onError),
                                  suffixIcon:  InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: viewModel.changeVisibilityPassword,
                                      child: Icon(viewModel.seePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                        color: theme.colorScheme.secondary,
                                      )
                                  )
                              ),
                              onTapOutside: (_) => viewModel.passwordFocus.unfocus(),
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
                        onPressed: () => viewModel.submit(context),
                        child: const Text("SALVAR"),
                      ),
                    ),

                    Text(
                      '---  ou  ---',
                      style: theme.textTheme.bodySmall,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GalaxyButton(
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        onPressed: () => viewModel.signin(context),
                        child: const Text("ENTRE"),
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