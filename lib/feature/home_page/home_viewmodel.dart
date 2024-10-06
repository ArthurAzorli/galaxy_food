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
import '../../core/widgets/galaxy_button.dart';

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
      showDialog(
          context: context,
          builder: (context)
          {
            final theme = Theme.of(context);
            return AlertDialog(

              icon: Icon(
                  Icons.warning_amber_rounded, color: theme.colorScheme.secondary,
                  size: 65),
              title: Text("Erro ${e.status}!", style: theme.textTheme.titleLarge),
              content: Text(e.message, style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: GalaxyButton(
                      style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(200, 50))
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go("/signin");
                      },
                      child: const Text("FECHAR")
                  ),
                )
              ],
            );
          }
      );
    }
  }
  void _getRestaurants(BuildContext context) async{
    try {
      restaurants = await RestaurantRepositoryService.getAll();
    } on RepositoryException catch(e) {
      showDialog(
          context: context,
          builder: (context)
          {
            final theme = Theme.of(context);
            return AlertDialog(

              icon: Icon(
                  Icons.warning_amber_rounded, color: theme.colorScheme.secondary,
                  size: 65),
              title: Text("Erro ${e.status}!", style: theme.textTheme.titleLarge),
              content: Text(e.message, style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: GalaxyButton(
                      style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(200, 50))
                      ),
                      onPressed: () {
                        exit(1);
                      },
                      child: const Text("FECHAR")
                  ),
                )
              ],
            );
          }
      );
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
      showDialog(
          context: context,
          builder: (context)
          {
            final theme = Theme.of(context);
            return AlertDialog(

              icon: Icon(
                  Icons.warning_amber_rounded, color: theme.colorScheme.secondary,
                  size: 65),
              title: Text("Erro ${e.status}!", style: theme.textTheme.titleLarge),
              content: Text(e.message, style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: GalaxyButton(
                      style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(200, 50))
                      ),
                      onPressed: () {
                        exit(1);
                      },
                      child: const Text("FECHAR")
                  ),
                )
              ],
            );
          }
      );
    }
    return null;
  }

  @action
  void seeRestaurant(BuildContext context,Restaurant restaurant){
    context.go("/restaurant", extra: restaurant);
  }
}

