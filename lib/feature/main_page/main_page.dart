import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_food/feature/home_page/home_page.dart';
import 'package:galaxy_food/feature/main_page/main_viewmodel.dart';
import 'package:galaxy_food/feature/order_page/order_page.dart';
import 'package:galaxy_food/feature/search_page/search_page.dart';
import 'package:galaxy_food/feature/user_page/user_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();

}

class MainPageState extends State<MainPage>{

  late final MainViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = GetIt.I.get<MainViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
        height: 78,
        color: theme.colorScheme.secondary,
        child: Observer(
          builder: (context) {
            return CurvedNavigationBar(
              index: viewModel.value,
              animationCurve: Curves.fastEaseInToSlowEaseOut,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: theme.colorScheme.primary,
              color: theme.colorScheme.primaryContainer,
              animationDuration: const Duration(milliseconds: 500),
              items: const [
                Icon(Icons.home, size: 30),
                Icon(Icons.search_rounded, size: 30),
                Icon(Icons.history, size: 30),
                Icon(Icons.person_rounded, size: 30),
              ],
              onTap: viewModel.onSelectPage,
            );
          }
        ),
      ),
      body: PageView(
        controller: viewModel.pageController,
        onPageChanged: viewModel.onChangePage,
        children: const [
          HomePage(),
          SearchPage(),
          OrderPage(),
          UserPage()
        ],
      ),
    );
  }

}