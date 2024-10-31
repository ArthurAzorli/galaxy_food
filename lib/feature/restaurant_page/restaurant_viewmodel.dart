import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_food/core/domain/package.dart';
import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:galaxy_food/core/domain/payment_form.dart';
import 'package:galaxy_food/core/domain/restaurant.dart';
import 'package:galaxy_food/core/service/repository/buy_repository_service.dart';
import 'package:galaxy_food/core/service/repository/package_repository_service.dart';
import 'package:galaxy_food/core/service/repository/restaurant_repository_service.dart';
import 'package:galaxy_food/core/utils/exception/repository_exception.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/food_item/food_item.dart';
import 'package:galaxy_food/feature/main_page/main_page.dart';
import 'package:galaxy_food/feature/main_page/main_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/domain/address.dart';
import '../../core/domain/buy.dart';
import '../../core/domain/client.dart';
import '../../core/service/repository/client_repository_service.dart';

part 'restaurant_viewmodel.g.dart';

class RestaurantViewModel = RestaurantViewModelBase with _$RestaurantViewModel;

abstract class RestaurantViewModelBase with Store{

  RestaurantViewModelBase(BuildContext context){
    _getRestaurant(context);
    _getClient(context);
  }

  @observable
  bool initBuy = false;

  @observable
  Restaurant? restaurant;

  @observable
  Client? client;

  @observable
  Address? addressSelected;

  @observable
  Package? root;

  @observable
  int? buyCount;

  @observable
  double score = 0;

  @observable
  double totalValue = 0;

  @observable
  ObservableMap<PackageItem, int> listBuy = ObservableMap();

  @action
  List<Widget>? getMenu(BuildContext context){
    if (root != null) return _buildRecursiveMenu(context, root!, true);
    return null;
  }

  @action
  backToHome(BuildContext context) {
    context.go("/");
  }

  @action
  cancel(){
    initBuy = false;
    listBuy.clear();
  }

  @action
  removeBuyItem(PackageItem item){
    listBuy.remove(item);
    if (listBuy.isEmpty) {
      initBuy = false;
      listBuy.clear();
    }
    _getTotalValue();
  }

  @action
  void avalition(BuildContext context){
    double value = 0;
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Avalie o Restaurante!"),
            content: Builder(
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 35,
                      child: Center(
                        child: AnimatedRatingStars(
                          filledColor: Colors.amber,
                          starSize: 35,
                          onChanged: (score) => value = score,
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                        ),
                      ),
                    ),
                  );
                }
            ),
            actions: [
              Center(
                child: GalaxyButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50))
                    ),
                    onPressed: () async {
                      try{
                        if (restaurant != null && client != null && client!.id != null) {
                          restaurant = await RestaurantRepositoryService.score(restaurant!.id, client!.id!, value);
                          score = restaurant!.score;
                        }
                        Navigator.pop(context);
                      } on RepositoryException catch(e){
                        Navigator.pop(context);
                        e.showMessageDialog(context, () => Navigator.pop(context));
                      }

                    },
                    child: const Text("ENVIAR")
                ),
              )
            ],
          );
        }
    );
  }

  @action
  void add(PackageItem item){
    listBuy[item] = listBuy[item]! + 1;
    _getTotalValue();
  }

  @action
  void rem(PackageItem item){
    listBuy[item] = listBuy[item]! - 1;
    if (listBuy[item]! <= 0){
      listBuy.remove(item);
      if (listBuy.isEmpty) {
        initBuy = false;
        listBuy.clear();
      }
    }
    _getTotalValue();
  }

  _getRestaurant(BuildContext context) async {
    try{
      String? id = GetIt.I.get<SharedPreferencesWithCache>().getString("restaurant");
      if (id == null) throw RepositoryException(status: 404, message: "Erro ao Carregar Restaurante!");

      restaurant = await RestaurantRepositoryService.get(id);
      buyCount = await BuyRepositoryService.getCountBuy(id);
      root = await PackageRepositoryService.rootOf(id);
      score = restaurant?.score??0;


    } on RepositoryException catch(e){
      e.showMessageDialog(context, ()=>Navigator.pop(context));
      context.go("/");
    }
  }

  void _getClient(BuildContext context) async {
    try {
      client = await ClientRepositoryService.getUser();
      addressSelected = _getAddressSelected();
    } on RepositoryException catch (e) {
      e.showMessageDialog(context, () => Navigator.of(context).pop());
    }
  }

  @action
  Address? _getAddressSelected(){
    final prefs = GetIt.I.get<SharedPreferencesWithCache>();
    String? id = prefs.getString("address");
    if (id == null) return null;
    if (client == null || client!.addresses.isEmpty) return null;

    for (var i = 0; i < client!.addresses.length; i++){
      if (client!.addresses[i].id == id) {
        return client!.addresses[i];
      }
    }

    return null;
  }

  @action
  finishBuy(BuildContext context){
    final key = GlobalKey<_ComboBoxState>();
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Escolha a forma de pagamento", textAlign: TextAlign.center,),
            content: _ComboBox(key: key),
            actions: [
              Center(
                child: GalaxyButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50))
                    ),
                    onPressed: () async {
                      final payment = key.currentState?.paymentForm;
                      if (payment == null) return;

                      try{

                        if (client == null) throw RepositoryException(status: 404, message: "Você pode estar deslogado!");
                        if (restaurant == null) throw RepositoryException(status: 404, message: "Restaurante inválido!");
                        if (addressSelected == null) throw RepositoryException(status: 404, message: "Nenhum Endereço Selecionado!");

                        final listBuy = <BuyItem>[];
                        for (final item in this.listBuy.entries){
                          final buyItem = BuyItem(item: item.key, quantity: item.value);
                          listBuy.add(buyItem);
                        }

                        Buy buy = Buy(
                            paymentForm: payment,
                            date: DateTime.now(),
                            items: listBuy,
                            sentAddress: addressSelected!,
                            client: client!,
                            restaurant: restaurant!
                        );
                        await BuyRepositoryService.create(buy);

                        initBuy = false;
                        listBuy.clear();
                        context.go("/");
                        GetIt.I.get<MainViewModel>().pageController.animateToPage(
                            2, duration: kThemeChangeDuration, curve: Curves.linear
                        );

                      } on RepositoryException catch(e){
                        e.showMessageDialog(context, () => Navigator.pop(context));
                      }

                    },
                    child: const Text("CONTINUAR")
                ),
              )
            ],
          );
        }
    );
  }

  Widget _buildExtensionTile(BuildContext context, Package package,  bool value, List<Widget> children){
    final theme = Theme.of(context);
    final controller = ExpansionTileController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
      child: ExpansionTile(
        controller: controller,
        title: Text(package.name, style: theme.textTheme.titleMedium,),
        tilePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        iconColor: theme.colorScheme.secondary,
        collapsedIconColor: theme.colorScheme.secondary,
        backgroundColor: value? theme.colorScheme.surface : theme.colorScheme.onSurface,
        collapsedBackgroundColor: value? theme.colorScheme.surface : theme.colorScheme.onSurface,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        children: children,
      ),
    );
  }

  List<Widget> _buildRecursiveMenu(BuildContext context, Package package, bool value){

    List<Widget> list= [];

    for (var child in package.children){
      var tile = _buildExtensionTile(context, child, value, _buildRecursiveMenu(context, child, !value));
      list.add(tile);
    }

    for (var item in package.items) {
      var tile = FoodItem(size: FoodItemSize.big, packageItem: item,
        onTap: (){
          initBuy = true;
          listBuy[item] = 1;
          _getTotalValue();
        },
      );
      list.add(tile);
    }

    return list;
  }


  _getTotalValue(){
    double total = 0;
    for (final buyItem in listBuy.entries){
      final price = buyItem.key.price;
      final qnt = buyItem.value;
      total += price*qnt;
    }
    totalValue = total;
  }

  String getTotalValueOfItem(PackageItem item){
    final price = item.price;
    final qnt = listBuy[item];
    return UtilBrasilFields.obterReal(price*qnt!);
  }

}

class _ComboBox extends StatefulWidget{

  const _ComboBox({super.key});

  @override
  State<StatefulWidget> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<_ComboBox>{

  PaymentForm? paymentForm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      child: DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        borderRadius:  const BorderRadius.all(Radius.circular(5)),
        style: theme.textTheme.bodyLarge,
        value: paymentForm,
        iconSize: 40,
        items: List.generate(
          PaymentForm.values.length,
              (index) => DropdownMenuItem(
              value: PaymentForm.values[index],
              child: Text("${PaymentForm.values[index].name}               ",)
          ),
        ),
        alignment: Alignment.centerRight,
        onChanged: (value) => setState(() => paymentForm = value),
        menuWidth: 225,
      ),
    );
  }

}

