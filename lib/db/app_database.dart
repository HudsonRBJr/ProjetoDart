import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/consumo_agua.dart';

class AppDatabase {
  static const String _databaseName = 'controle_agua.db';
  static const int _databaseVersion = 1;
  static const String tableConsumos = 'consumos_agua';

  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
    );

    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableConsumos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        atividade TEXT NOT NULL,
        litros REAL NOT NULL,
        horario TEXT NOT NULL
      )
    ''');
  }

  Future<List<ConsumoAgua>> listarConsumos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableConsumos,
      orderBy: 'id DESC',
    );

    return maps.map(ConsumoAgua.fromMap).toList();
  }

  Future<ConsumoAgua> cadastrarConsumo(ConsumoAgua consumo) async {
    final Database db = await database;
    final int id = await db.insert(
      tableConsumos,
      consumo.toMap()..remove('id'),
    );

    return consumo.copyWith(id: id);
  }

  Future<ConsumoAgua> atualizarConsumo(ConsumoAgua consumo) async {
    if (consumo.id == null) {
      throw Exception('Não foi possível atualizar: consumo sem id.');
    }

    final Database db = await database;
    await db.update(
      tableConsumos,
      consumo.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: <Object?>[consumo.id],
    );

    return consumo;
  }

  Future<void> deletarConsumo(int id) async {
    final Database db = await database;
    await db.delete(
      tableConsumos,
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }
}
