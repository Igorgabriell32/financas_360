import 'package:financas_360/home/models/despesas.dart';

class PeriodoDespesas {
  late String nomeMes;
  late int ano;
  late List<Despesas> debitos;

  PeriodoDespesas({
    required this.nomeMes,
    required this.ano,
    required this.debitos,
  });
}
