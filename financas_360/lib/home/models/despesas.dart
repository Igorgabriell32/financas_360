import 'package:cloud_firestore/cloud_firestore.dart';

class Despesas {
  late String id;
  late String nomeDespesa;
  late double valor;
  late DateTime dataVencimento;
  late String status;

  Despesas(
      {required this.id,
      required this.nomeDespesa,
      required this.valor,
      required this.dataVencimento,
      required this.status});

  factory Despesas.fromMap(Map<String, dynamic> map) {
    String id = map['id'];
    String nomeDespesa = map["nome"];
    Timestamp dataVencimentoTimestamp = map["data_vencimento"];
    double valor = (map["valor"] ?? 0).toDouble();
    String status = map["status"];

    // Converta o Timestamp para DateTime
    DateTime dataVencimento = dataVencimentoTimestamp.toDate();

    return Despesas(
        id: id,
        nomeDespesa: nomeDespesa,
        dataVencimento: dataVencimento,
        valor: valor,
        status: status);
  }
}
