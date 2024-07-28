import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_food/feature/home_page/home_page.dart';
import 'package:galaxy_food/feature/order_page/order_page.dart';
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
    final theme = GalaxyFoodTheme.normal;

    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: GalaxyFoodTheme.normal,
      home: Scaffold(
        bottomNavigationBar: Container(
          height: 78,
          color: theme.colorScheme.secondary,
          child: CurvedNavigationBar(
            animationCurve: Curves.fastEaseInToSlowEaseOut,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: theme.colorScheme.primary,
            color: theme.colorScheme.primaryContainer,
            animationDuration: kThemeAnimationDuration,
            items: const [
              Icon(Icons.home, size: 30),
              Icon(Icons.shopping_cart_outlined, size: 30),
              Icon(Icons.history, size: 30),
              Icon(Icons.settings, size: 30),
            ],
          ),
        ),
        body: const OrderPage(),
      ),
    );
  }

}