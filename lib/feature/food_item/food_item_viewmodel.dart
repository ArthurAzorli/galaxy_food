import 'package:mobx/mobx.dart';

part 'food_item_viewmodel.g.dart';

class FoodItemViewModel = FoodItemViewModelBase with _$FoodItemViewModel;

abstract class FoodItemViewModelBase with Store{

  @observable
  int value = 1;

  @action
  void onAdd() => value++;


  @action
  void onRem(){
    if (value>1) value--;
  }

}

