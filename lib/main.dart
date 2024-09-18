import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/service/session_service.dart';
import 'package:galaxy_food/core/utils/route/go_route.dart';
import 'package:galaxy_food/feature/main_page/main_page.dart';
import 'package:galaxy_food/feature/signup_page/signup_page.dart';
import 'package:galaxy_food/feature/signin_page/signin_page.dart';
import 'package:galaxy_food/galaxy_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

setup(){
  final getIt = GetIt.I;
  getIt.registerSingleton<SessionService>(SessionService());
}

main(){
  runApp(const App());
}

GoRouter _router = GoRouter(
  initialLocation: "/signin",
  routes: [
    GoRouteUtils.buildHorizontalRoute(
      path: "/signin",
      buildChild: (BuildContext context, GoRouterState state) => const SignInPage(),
      restorationId: "SignIn-Page"
    ),

    GoRouteUtils.buildHorizontalRoute(
        path: "/signup",
        buildChild: (BuildContext context, GoRouterState state) => const SignUpPage(),
        restorationId: "SignUp-Page"
    ),

    GoRouteUtils.buildHorizontalRoute(
        path: "/",
        buildChild: (BuildContext context, GoRouterState state) => const MainPage(),
        restorationId: "Main-Page",
        routes: []
    ),
  ],
);

class App extends StatefulWidget{

  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      theme: GalaxyFoodTheme.normal,
      routerConfig: _router,
    );
  }

}