import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas_360/home/models/despesas.dart';
import 'package:financas_360/home/models/receita.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class CadastroController extends GetxController {
  late TextEditingController nomeDespesa = TextEditingController();
  late TextEditingController dateVenc = TextEditingController();
  late TextEditingController valorDespesa = TextEditingController();
  late TextEditingController statusDespesa = TextEditingController();
  late TextEditingController origereceita = TextEditingController();
  late TextEditingController dateRecebe = TextEditingController();
  late TextEditingController valorReceita = TextEditingController();
  late TextEditingController statusReceita = TextEditingController();

  late RxList<Despesas> despesas = <Despesas>[].obs;
  late RxList<Credito> credito = <Credito>[].obs;

  RxBool selectCardCred = false.obs;
  RxBool selectCardDebit = false.obs;
  var uuid = Uuid();

  @override
  onInit() {
    buscaDespesas();
    buscaReceita();
    super.onInit();
  }

  buscaDespesas() async {
    despesas = <Despesas>[].obs;

    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Periodo')
        .doc('Dezembro')
        .collection('Despesas')
        .get();

    for (var docs in snapshot.docs) {
      Despesas desp = Despesas.fromMap(docs.data());
      print(desp.nomeDespesa);
      despesas.add(desp);
    }
  }

  buscaReceita() async {
    try {
      credito = <Credito>[].obs;

      FirebaseFirestore fb = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> Snapshot = await fb
          .collection('Periodo')
          .doc('Dezembro')
          .collection('Receitas')
          .get();

      for (var docs in Snapshot.docs) {
        Credito cred = Credito.fromMap(docs.data());
        credito.add(cred);
      }
    } catch (erro) {
      print('Erro ao buscar Receitas ${erro}');
    }
  }

  salvaDespesa() async {
    var v4 = uuid.v4();

    try {
      Despesas desp = Despesas(
          id: v4.toString(),
          nomeDespesa: nomeDespesa.text,
          dataVencimento: DateTime.tryParse(dateVenc.text) ?? DateTime.now(),
          valor: double.parse(valorDespesa.text.toString()),
          status: statusDespesa.text);
      print(desp.nomeDespesa);
      despesas.add(desp);
      print(despesas.first.dataVencimento);
      update();

      FirebaseFirestore db = FirebaseFirestore.instance;

      await db
          .collection('Periodo')
          .doc('Dezembro')
          .collection('Receitas')
          .doc(v4)
          .set({
        'nome': desp.nomeDespesa,
        'data_vencimento': desp.dataVencimento,
        'valor': desp.valor,
        'status': desp.status,
        'id': v4
      });

      nomeDespesa.clear();
      dateVenc.clear();
      valorDespesa.clear();
      statusDespesa.clear();
    } catch (erro) {
      print(erro);
    }
  }

  salvaReceita() async {
    var v4 = uuid.v4();

    try {
      Credito cred = Credito(
          id: v4,
          origemReceita: origereceita.text,
          dataRecebimento: DateTime.tryParse(dateRecebe.text) ?? DateTime.now(),
          valor: double.parse(
            valorReceita.text.toString(),
          ),
          status: statusReceita.text);

      credito.add(cred);

      update();

      FirebaseFirestore Fb = FirebaseFirestore.instance;

      Fb.collection('Periodo')
          .doc('Dezembro')
          .collection('Receitas')
          .doc(v4)
          .set({
        'id': v4.toString(),
        'nome': cred.origemReceita,
        'data_vencimento': cred.dataRecebimento,
        'valor': cred.valor,
        'status': cred.status,
      });

      origereceita.clear();
      dateRecebe.clear();
      valorReceita.clear();
      statusReceita.clear();
    } catch (erro) {
      print('Erro');
    }
  }

  aletraSelecaoCred() {
    selectCardDebit.value = false;
    selectCardCred.value = !selectCardCred.value;
  }

  aletraSelecaoDebit() {
    selectCardCred.value = false;
    selectCardDebit.value = !selectCardDebit.value;
  }

  deletaCredit(index) {
    FirebaseFirestore fb = FirebaseFirestore.instance;

    fb
        .collection('Periodo')
        .doc('Dezembro')
        .collection('Receitas')
        .doc(credito[index].id)
        .delete();

    credito.removeAt(index);
  }

  deletaDebit(index) {
    FirebaseFirestore fb = FirebaseFirestore.instance;

    fb
        .collection('Periodo')
        .doc('Dezembro')
        .collection('Debitos')
        .doc(despesas[index].id)
        .delete();

    despesas.removeAt(index);
  }

  editarReceita(index) {
    origereceita.text = credito[index].origemReceita.toString();
    dateRecebe.text = credito[index].dataRecebimento.toString();
    valorReceita.text = credito[index].valor.toString();
    statusReceita.text = credito[index].status.toString();
  }

  editaReceita(index) async {
    try {
      FirebaseFirestore Fb = FirebaseFirestore.instance;

      print(credito[index].id.toString());

      await Fb.collection('Periodo')
          .doc('Dezembro')
          .collection('Receitas')
          .doc(credito[index].id.toString())
          .set({
        'id': credito[index].id.toString(),
        'nome': origereceita.text,
        'data_vencimento': DateTime.tryParse(dateRecebe.text) ?? DateTime.now(),
        'valor': double.parse(valorReceita.text.toString()),
        'status': statusReceita.text,
      });

      origereceita.clear();
      dateRecebe.clear();
      valorReceita.clear();
      statusReceita.clear();

      await buscaReceita();

      update();
    } catch (erro) {
      print('Erro');
    }
  }
}
