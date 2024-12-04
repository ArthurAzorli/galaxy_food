import 'package:brasil_fields/brasil_fields.dart';
import 'package:galaxy_food/core/domain/buy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PDFGenerate {

  final Buy buy;
  final document = Document();

  PDFGenerate(this.buy);

  PDFGenerate build() {
    document.addPage(
      MultiPage(
        margin: EdgeInsets.zero,
        header: _buildHeader,
        footer: _buildFooter,
        build: (context){
          return [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Cliente:", style: const TextStyle(fontSize: 14))
                      ),
                      Text(buy.client.name, style: const TextStyle(fontSize: 12)),
                      Text(buy.client.cpf, style: const TextStyle(fontSize: 12)),

                      Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            width: 200,
                            child: Text("Endereço:", style: const TextStyle(fontSize: 14))
                          )
                      ),
                      Text(buy.sentAddress.toString(), style: const TextStyle(fontSize: 12)),
                    ]
                  ),

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("ID Compra:", style: const TextStyle(fontSize: 14))
                        ),
                        Text(buy.id!, style: const TextStyle(fontSize: 10)),

                        Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("Data:", style: const TextStyle(fontSize: 14))
                        ),
                        Text("${UtilData.obterDataDDMMAAAA(buy.date)} as ${UtilData.obterHoraHHMM(buy.date)}", style: const TextStyle(fontSize: 12)),
                      ]
                  ),

                ]
              )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Table(
                  
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: PdfColor.fromInt(0xff9e1414),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                          child: Text("Nome", style: const TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                          child: Text("Preço Unitário", style: const TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                          child: Text("Quantidade", style: const TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                          child: Text("Total", style: const TextStyle(color: PdfColor.fromInt(0xffffffff), fontSize: 14)),
                        ),
                      ]
                    ),

                    ...List.generate(
                        buy.items.length,
                            (index){
                          final item = buy.items[index];
                          return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(item.item.name)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(UtilBrasilFields.obterReal(item.item.price))
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text("${item.quantity}x")
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(UtilBrasilFields.obterReal(item.item.price*item.quantity)),
                                  )
                                ),
                              ]
                          );
                        }
                    )
                  ]
                )
            ),
          ];
        }
      )
    );

    return this;
  }

  save() async{
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => document.save()
    );
  }

  Widget _buildHeader(Context context){

    return Container(
        color: const PdfColor.fromInt(0xff9e1414),
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(buy.restaurant.name, style: const TextStyle(fontSize: 22, color: PdfColor.fromInt(0xffffffff))),
                  SizedBox(
                    width: 200,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        buy.restaurant.address.toString(),
                        style: const TextStyle(color: PdfColor.fromInt(0xffffffff)),
                        textAlign: TextAlign.end
                      )
                    )
                  )
                ]
              )
            ]
          )
        )
    );
  }

  Widget _buildFooter(Context context){
    return Container(
      height: 200,
      color: const PdfColor.fromInt(0xff9e1414),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forma de Pagamento: ${buy.paymentForm.toString()}", style: const TextStyle(fontSize: 14, color: PdfColor.fromInt(0xffffffff))),
                    Padding(padding: const EdgeInsets.only(top: 5)),
                    Text("Desconto:", style: const TextStyle(fontSize: 14,color: PdfColor.fromInt(0xffffffff))),
                    Text(UtilBrasilFields.obterReal(buy.discount), style: const TextStyle(fontSize: 15, color: PdfColor.fromInt(0xffffffff))),
                    Padding(padding: const EdgeInsets.only(top: 5)),
                    Text("Taxa de Entrega:", style: const TextStyle(fontSize: 14, color: PdfColor.fromInt(0xffffffff))),
                    Text(UtilBrasilFields.obterReal(buy.deliveryFee), style: const TextStyle(fontSize: 15, color: PdfColor.fromInt(0xffffffff)))
                  ]
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Valor Total:", style: const TextStyle(fontSize: 14, color: PdfColor.fromInt(0xffffffff))),
                    Text(UtilBrasilFields.obterReal(totalValue), style: const TextStyle(fontSize: 25, color: PdfColor.fromInt(0xffffffff)))
                  ]
              )
            ]
        )
      )
    );
  }

  double get totalValue{
    var value = 0.0;
    for (final item in buy.items){
      value += item.quantity*item.item.price;
    }
    return value;
  }
}