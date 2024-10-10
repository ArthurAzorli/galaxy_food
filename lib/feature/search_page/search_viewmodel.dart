import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/restaurant_repository_service.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/package_item.dart';
import '../../core/domain/restaurant.dart';
import '../../core/service/repository/food_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';

part 'search_viewmodel.g.dart';

class SearchViewModel = SearchViewModelBase with _$SearchViewModel;

abstract class SearchViewModelBase with Store {

    @observable
    var focusSearch = FocusNode();

    @observable
    var textEditingControllerSearch = TextEditingController();

    @observable
    List<Restaurant> restaurants = [];

    @observable
    bool beforeSearch = false;

    @action
    search(BuildContext context) async {
        final text = textEditingControllerSearch.text;
        try {
            restaurants = await RestaurantRepositoryService.search(text);
            beforeSearch = true;
        } on RepositoryException catch(e) {
            e.showMessageDialog(context, () => Navigator.of(context).pop());
        }
    }

    @action
    Future<List<PackageItem>?> getFoodItemOf(BuildContext context, Restaurant restaurant) async{
        try{
            return await FoodRepositoryService.getOf(restaurant.id);
        } on RepositoryException catch(e) {
            e.showMessageDialog(context, (){
                Navigator.of(context).pop();
                exit(1);
            });
        }
        return null;
    }

    @action
    reset(){
        beforeSearch = false;
        restaurants = [];
    }

    @action
    void seeRestaurant(BuildContext context,Restaurant restaurant){
        context.go("/restaurant", extra: restaurant);
    }


}