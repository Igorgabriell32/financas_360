import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas_360/cadastroDespesas/cadastro_controller.dart';
import 'package:financas_360/home/enum/enum_mes.dart';
import 'package:financas_360/home/models/despesas.dart';
import 'package:financas_360/home/models/receita.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CadastroDespesa extends StatelessWidget {
  CadastroDespesa({super.key});

  final controller = Get.put(CadastroController());

  Widget graficoDespesa() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 200,
        child: Center(
          child: PieChart(PieChartData(sections: [
            PieChartSectionData(
              title: 'Agua',
              value: 50,
              color: Color.fromARGB(255, 102, 255, 0),
            ),
            PieChartSectionData(
              title: 'Energia',
              value: 25,
              color: Colors.green,
            ),
            PieChartSectionData(
              title: 'Alimentacao',
              value: 25,
              color: const Color.fromARGB(255, 19, 131, 223),
            ),
          ])),
        ),
      ),
    );
  }

  Widget despesas() {
    return SingleChildScrollView(
      child: GetBuilder<CadastroController>(
        builder: (_) => Column(
          children: [
            Text(
              'Despesas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Obx(
              () => _.despesas.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () => controller.buscaDespesas(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.despesas.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: ValueKey<Despesas>(
                                  controller.despesas[index]),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 5),
                                color: const Color.fromARGB(255, 243, 32, 17),
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              onDismissed: (direction) =>
                                  controller.deletaDebit(index),
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color:
                                            Color.fromRGBO(26, 19, 107, 0.973),
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 17.0),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.red.shade700,
                                                    size: 60,
                                                  ),
                                                  Text(
                                                      controller.despesas[index]
                                                          .status,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              26,
                                                              19,
                                                              107,
                                                              0.973),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'Nome',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          26, 19, 107, 0.973),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                    controller.despesas[index]
                                                        .nomeDespesa,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            26, 19, 107, 0.973),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Data Vencimento',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            26, 19, 107, 0.973),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(controller
                                                            .despesas[index]
                                                            .dataVencimento),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            26, 19, 107, 0.973),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Valor',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            26, 19, 107, 0.973),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                    controller.despesas[index].valor
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            26, 19, 107, 0.973),
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }

  Widget receita() {
    return SingleChildScrollView(
      child: GetBuilder<CadastroController>(
        builder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Receitas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Obx(
                () => _.credito.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () => controller.buscaReceita(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.credito.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                key: ValueKey<Credito>(
                                    controller.credito[index]),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 5),
                                  color: const Color.fromARGB(255, 243, 32, 17),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                onDismissed: (direction) =>
                                    controller.deletaCredit(index),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.editarReceita(index);

                                    print(controller.origereceita.text);

                                    _showCadastroReceita(context,
                                        cred: controller.credito[index],
                                        index: index);
                                  },
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Color.fromRGBO(
                                                26, 19, 107, 0.973),
                                            width: 5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 17.0),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.arrow_drop_up,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 27, 236, 34),
                                                        size: 60,
                                                      ),
                                                      Text(
                                                          controller
                                                              .credito[index]
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      26,
                                                                      19,
                                                                      107,
                                                                      0.973),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Nome',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              26,
                                                              19,
                                                              107,
                                                              0.973),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                        controller
                                                            .credito[index]
                                                            .origemReceita,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    19,
                                                                    107,
                                                                    0.973),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Data Recebimento',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    19,
                                                                    107,
                                                                    0.973),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(controller
                                                                .credito[index]
                                                                .dataRecebimento),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    19,
                                                                    107,
                                                                    0.973),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Valor',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    19,
                                                                    107,
                                                                    0.973),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                        controller.credito[index].valor
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    26,
                                                                    19,
                                                                    107,
                                                                    0.973),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget botaoAdicionarDesp(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Row(
        children: [
          FloatingActionButton(
            backgroundColor: Color.fromRGBO(56, 135, 190, 0.973),
            onPressed: () => {_showDebiCred(context)},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void _showCadastroDispesa(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: Colors.red.shade700,
                size: 60,
              ),
              SizedBox(
                width: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Cadastro Conta'),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Nome da Despesa',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.nomeDespesa,
                      decoration: InputDecoration(hintText: 'nome'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Data Vencimento',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(56, 65, 157, 0.973)),
                ),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.dateVenc,
                      decoration: InputDecoration(hintText: '00/00/00'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text('Valor',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.valorDespesa,
                      decoration: InputDecoration(hintText: 'R\$'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text('Staus',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.statusDespesa,
                      decoration: InputDecoration(
                          hintText: 'Pago, Pendente ou Vencido'),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para cancelar a seleção
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                controller.salvaDespesa();

                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showCadastroReceita(BuildContext context, {Credito? cred, index}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.arrow_drop_up,
                color: Color.fromARGB(255, 11, 236, 19),
                size: 60,
              ),
              SizedBox(
                width: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cred == null
                      ? Text('Cadastro Recieta')
                      : Text('Editar ${cred.origemReceita}'),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Origem da Recita',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.origereceita,
                      decoration: InputDecoration(hintText: 'nome'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Data Recebimento',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromRGBO(56, 65, 157, 0.973)),
                ),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.dateRecebe,
                      decoration: InputDecoration(hintText: '00/00/00'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text('Valor',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.valorReceita,
                      decoration: InputDecoration(hintText: 'R\$'),
                    )),
                SizedBox(
                  height: 8,
                ),
                Text('Staus',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(56, 65, 157, 0.973))),
                Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      controller: controller.statusReceita,
                      decoration: InputDecoration(
                          hintText: 'Recebido, Pendente, Receber'),
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para cancelar a seleção
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                cred == null
                    ? controller.salvaReceita()
                    : controller.editaReceita(index);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showDebiCred(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                Icons.compare_arrows_outlined,
                color: Colors.black,
                size: 60,
              ),
              SizedBox(
                width: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tipo de Evento'),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
              child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.aletraSelecaoCred();
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: controller.selectCardCred.value
                                ? Color.fromARGB(255, 0, 125, 134)
                                : Colors.white)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_drop_up,
                            color: const Color.fromARGB(255, 27, 216, 36),
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Crédito',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.aletraSelecaoDebit();
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: controller.selectCardDebit.value
                                ? Color.fromARGB(255, 0, 125, 134)
                                : Colors.white)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color.fromARGB(255, 243, 13, 13),
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Debito',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para cancelar a seleção
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                if (controller.selectCardCred.value) {
                  _showCadastroReceita(context);
                } else {
                  _showCadastroDispesa(context);
                }
              },
              child: Text('criar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 19, 107, 0.973),
        title: Row(
          children: [
            Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Finanças',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            graficoDespesa(),
            despesas(),
            receita(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                botaoAdicionarDesp(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
