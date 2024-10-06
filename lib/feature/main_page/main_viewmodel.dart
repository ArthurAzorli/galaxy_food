import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store{

  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @observable
  int addressSelect = 0;

  @observable
  int value = 0;

  @action
  void onChangePage(int newValue){
    value = newValue;
  }

  @action
  void onSelectPage(int index){
    pageController.animateToPage(
        index,
        duration: kThemeChangeDuration,
        curve: Curves.fastOutSlowIn
    );
    value = index;
  }
}