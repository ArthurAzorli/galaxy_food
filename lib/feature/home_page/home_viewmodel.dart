import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galaxy_food/core/domain/address.dart';
import 'package:galaxy_food/core/domain/client.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/service/repository/food_repository_service.dart';
import 'package:galaxy_food/core/service/repository/restaurant_repository_service.dart';
import 'package:galaxy_food/feature/main_page/main_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/package_item.dart';
import '../../core/domain/restaurant.dart';
import '../../core/utils/exception/repository_exception.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store{

  @observable
  Client? client;

  @observable
  List<Restaurant> restaurants = [];

  HomeViewModelBase(BuildContext context){
    _getClient(context);
    _getRestaurants(context);
  }

  void _getClient(BuildContext context) async{
    try {
      client = await ClientRepositoryService.getUser();

    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }
  void _getRestaurants(BuildContext context) async{
    try {
      restaurants = await RestaurantRepositoryService.getAll();
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
        exit(1);
      });
    }
  }

  @computed
  Address? get addressSelect{
    if (client == null || client!.addresses.isEmpty) return null;
    return client!.addresses[GetIt.I.get<MainViewModel>().addressSelect];
  }

  @action
  void search(){
    GetIt.I.get<MainViewModel>().onSelectPage(1);
  }

  @action
  Future<List<PackageItem>?> getFoodItemOf(BuildContext context, Restaurant restaurant) async{
    try{
      return await FoodRepositoryService.getOf(restaurant.id);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () {
        Navigator.pop(context);
        exit(1);
      });
    }
    return null;
  }

  @action
  void seeRestaurant(BuildContext context,Restaurant restaurant){
    context.go("/restaurant", extra: restaurant);
  }
}

