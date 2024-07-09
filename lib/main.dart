import 'package:flutter/material.dart';
import 'package:galaxy_food/galaxy_theme.dart';

main(){
  runApp(const App());
}

class App extends StatefulWidget{

  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: GalaxyFoodTheme.normal,
    );
  }

}