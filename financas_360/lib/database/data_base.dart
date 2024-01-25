import 'package:financas_360/home/models/despesas.dart';
import 'package:financas_360/home/models/receita.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase({String? table}) async {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'dbFin360.db');

    if (table == 'debitos') {
      return openDatabase(path, onCreate: (db, version) {
        db.execute(
            "CREATE TABLE debitos('id' INTEGER PRIMARY KEY, 'nome' TEXT, 'valor' NUMERIC, 'data_vencimento' TEXT, 'status' TEXT)");
      }, version: 1);
    } else {
      return openDatabase(path, onCreate: (db, version) {
        db.execute(
            "CREATE TABLE creditos('id' INTEGER PRIMARY KEY, 'nome' TEXT,'valor' NUMERIC, 'data_vencimento' TEXT, 'status' TEXT)");
      }, version: 1);
    }
  });
}

Future<int> save(String table, {Despesas? despesas, Credito? credito}) async {
  try {
    Database db = await createDatabase(table: table);

    final Map<String, dynamic> Mapdespesas = Map();
    if (despesas != null) {
      print(
          'Iniciando Insert:  despesas: ${despesas.dataVencimento.toString()}');
      Mapdespesas['id'] = int.tryParse(despesas.id);
      Mapdespesas['nome'] = despesas.nomeDespesa;
      Mapdespesas['data_vencimento'] = despesas.dataVencimento.toString();
      Mapdespesas['valor'] = despesas.valor;
    }

    if (credito != null) {
      Mapdespesas['id'] = credito.id;
      Mapdespesas['nome'] = credito.origemReceita;
      Mapdespesas['data_vencimento'] = credito.dataRecebimento;
      Mapdespesas['valor'] = credito.valor;
    }

    int id = await db.insert(table, Mapdespesas);
    print(id);
    return id;
  } catch (erro) {
    print('ERRO AO EXECUTAR INSERT !!! ${erro}');
  } finally {
    return 1;
  }
}

Future<dynamic> findAll(String table) async {
  try {
    Database db = await createDatabase(table: table);

    if (table == 'debitos') {
      late List<Despesas> desp = <Despesas>[];

      db.query(table).then((maps) {
        for (Map<String, dynamic> map in maps) {
          final Despesas des = Despesas(
              id: map['id'],
              nomeDespesa: map['nome'],
              dataVencimento: map['data_vencimento'],
              status: map['status'],
              valor: map['valor']);

          desp.add(des);
        }
      });

      return desp;
    } else {
      late List<Credito> credit = <Credito>[];

      db.query(table).then((maps) {
        for (Map<String, dynamic> map in maps) {
          final Credito cred = Credito(
              id: map['id'],
              origemReceita: map['nome'],
              dataRecebimento: map['data_vencimento'],
              status: map['status'],
              valor: map['valor']);

          credit.add(cred);
        }
      });

      return credit;
    }
  } catch (erro) {
    print('Erro ao executar select');
  }
}
