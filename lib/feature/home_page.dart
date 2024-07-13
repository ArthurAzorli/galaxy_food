import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: theme.colorScheme.primary,
        color: theme.colorScheme.primaryContainer,
        animationDuration: kThemeAnimationDuration,
        items: const [
          Icon(Icons.home, size: 35),
          Icon(Icons.shopping_cart_outlined, size: 35),
          Icon(Icons.history, size: 35),
          Icon(Icons.settings, size: 35),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async => await Future.delayed(const Duration(seconds: 2)),
        backgroundColor: theme.colorScheme.primary,
        color: theme.colorScheme.secondary,
        springAnimationDurationInMilliseconds: 200,
        borderWidth: 5,
        height: 300,
        child: ListView(
          children: [
            for (int i = 0; i<5; i++)
              Container(
                height: 200,
                width: double.maxFinite,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.colorScheme.inverseSurface,
                ),
              )
          ],
        )
      )
    );
  }

}