import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/buy_repository_service.dart';
import 'package:galaxy_food/core/utils/exception/repository_exception.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/buy.dart';
import '../../core/service/pdf_generate.dart';
import '../../core/widgets/galaxy_button.dart';

part 'order_viewmodel.g.dart';

class OrderViewModel = OrderViewModelBase with _$OrderViewModel;

abstract class OrderViewModelBase with Store {

  @observable
  List<Buy> oldOrders = [];

  @observable
  List<Buy> newOrders = [];

  @action
  update(BuildContext context) async {
    try {
      final buys = await BuyRepositoryService.getAll();
      final oldOrders = <Buy>[];
      final newOrders = <Buy>[];



      for (var buy in buys){
        if (buy.date.difference(DateTime.now()).inHours<-24){
          oldOrders.add(buy);
        } else {
          newOrders.add(buy);
        }
      }

      this.newOrders = newOrders;
      this.oldOrders = oldOrders;

    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () {
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }

  @action
  cancel(BuildContext context, Buy buy){
    try {
      BuyRepositoryService.cancel(buy.id!);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () => Navigator.pop(context));
    }
    update(context);
  }

  @action
  seeDetails(BuildContext context, Buy buy){
    final theme = Theme.of(context);

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Detalhes", style: theme.textTheme.titleLarge),
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(buy.restaurant.name, style: theme.textTheme.titleMedium?.merge(
                        const TextStyle(fontSize: 20,)
                    )),
                    Text("Endereço de Entrega: ${buy.sentAddress.toString()}", style: theme.textTheme.bodyLarge),
                
                    Padding(
                      padding: const EdgeInsets.only( top: 15),
                      child: Text("Data: ${UtilData.obterDataDDMMAAAA(buy.date)} ás ${UtilData.obterHoraHHMM(buy.date)}", style: theme.textTheme.bodyLarge),
                    ),
                    Text("Forma de Pagamento: ${buy.paymentForm.toString()}", style: theme.textTheme.bodyLarge),
                    Text("Valor Total: ${UtilBrasilFields.obterReal(_getTotalValue(buy))}", style: theme.textTheme.bodyLarge),
                    Text("Taxa de Entrega: ${UtilBrasilFields.obterReal(buy.deliveryFee)}", style: theme.textTheme.bodyLarge),
                    Text("Desconto Total: ${UtilBrasilFields.obterReal(buy.discount)}", style: theme.textTheme.bodyLarge),
                
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Text("Itens Comprados:", style: theme.textTheme.titleMedium),
                    ),

                    ...List.generate(
                      buy.items.length,
                      (index){
                        final item = buy.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 2.5),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            tileColor: theme.colorScheme.onSurface,
                            leading: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("${item.quantity}x", style: theme.textTheme.titleLarge,),
                            ),
                            title: Text(
                              "${item.item.name} - ${UtilBrasilFields.obterReal(item.item.price*item.quantity)}",
                              style: theme.textTheme.bodyLarge,
                            ),

                          ),
                        );
                      },
                    )
                
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: GalaxyButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50))
                    ),
                    onPressed: ()=>Navigator.pop(context),
                    child: const Text("FECHAR")
                ),
              )
            ],
          );
        }
    );
  }

  @action
  printing(Buy buy){
    PDFGenerate(buy).build().save();
  }

  @computed
  bool get listIsEmpty => newOrders.isEmpty && oldOrders.isEmpty;

  double _getTotalValue(Buy buy){
    var value = 0.0;
    for (final item in buy.items){
      value += item.quantity*item.item.price;
    }
    return value;
  }
}