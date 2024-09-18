import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/signin_page/signin_viewmodel.dart';


class SignInPage extends StatefulWidget{
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => SignInPageState();

}

class SignInPageState extends State<SignInPage>{
  final viewModel = SignInViewModel();

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
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Image.asset(
                  "lib/images/galaxyfood_logo.png",
                  height: 125,
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
                        "FAÇA SEU LOG IN",
                        style: theme.textTheme.titleLarge,
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
                                labelStyle: theme.textTheme.bodyLarge,
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
                                  labelStyle: theme.textTheme.bodyLarge,
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
                      padding: const EdgeInsets.only(top: 75, bottom: 10),
                      child: GalaxyButton(
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        onPressed: () async => await viewModel.submit(context),
                        child: const Text("ENTRE"),
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
                        onPressed: () => viewModel.signup(context),
                        child: const Text("CADASTRE-SE"),
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