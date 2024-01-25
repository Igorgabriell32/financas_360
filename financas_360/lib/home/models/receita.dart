import 'package:cloud_firestore/cloud_firestore.dart';

class Credito {
  late String id;
  late String origemReceita;
  late double valor;
  late DateTime dataRecebimento;
  late String status;

  Credito(
      {required this.id,
      required this.origemReceita,
      required this.valor,
      required this.dataRecebimento,
      required this.status});

  factory Credito.fromMap(Map<String, dynamic> map) {
    String id = map['id'];
    String origemReceita = map["nome"];
    Timestamp dataVencimentoTimestamp = map["data_vencimento"];
    double valor = (map["valor"] ?? 0).toDouble();
    String status = map["status"].toString();

    // Converta o Timestamp para DateTime
    DateTime dataVencimento = dataVencimentoTimestamp.toDate();

    return Credito(
        id: id,
        origemReceita: origemReceita,
        dataRecebimento: dataVencimento,
        valor: valor,
        status: status);
  }
}
