import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financas_360/database/data_base.dart';
import 'package:financas_360/home/models/despesas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'cadastroDespesas/cadastro_despesa.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(GetMaterialApp(
    home: CadastroDespesa(),
  ));

  // int d = await save('debitos',
  //     despesas: Despesas(
  //         id: '23',
  //         nomeDespesa: 'teste2024',
  //         valor: 53,
  //         dataVencimento: DateTime.now(),
  //         status: 'pendente'));

  // print('Iniciado: select');

  // findAll('debitos');

  // FirebaseFirestore Firestore = FirebaseFirestore.instance;

  // Firestore.collection('Colecao-01')
  //     .doc('igor')
  //     .collection('contas')
  //     .doc('Novembro')
  //     .set({'Energia': 661.75});
}
