import '../db/app_database.dart';
import '../models/consumo_agua.dart';
import '../services/consumo_agua_service.dart';

enum FontePersistencia { local, remota }

extension FontePersistenciaDescricao on FontePersistencia {
  String get descricao {
    switch (this) {
      case FontePersistencia.local:
        return 'SQLite local';
      case FontePersistencia.remota:
        return 'API Render/PostgreSQL';
    }
  }
}

class ConsumoAguaRepository {
  final AppDatabase _database;
  final ConsumoAguaService _service;
  FontePersistencia fonteAtual;

  ConsumoAguaRepository({
    AppDatabase? database,
    ConsumoAguaService? service,
    this.fonteAtual = FontePersistencia.local,
  })  : _database = database ?? AppDatabase.instance,
        _service = service ?? ConsumoAguaService();

  Future<List<ConsumoAgua>> listarConsumos() {
    if (fonteAtual == FontePersistencia.local) {
      return _database.listarConsumos();
    }

    return _service.listarConsumos();
  }

  Future<ConsumoAgua> salvarConsumo(ConsumoAgua consumo) {
    if (fonteAtual == FontePersistencia.local) {
      return _database.cadastrarConsumo(consumo);
    }

    return _service.cadastrarConsumo(consumo);
  }

  Future<ConsumoAgua> atualizarConsumo(ConsumoAgua consumo) {
    if (fonteAtual == FontePersistencia.local) {
      return _database.atualizarConsumo(consumo);
    }

    return _service.atualizarConsumo(consumo);
  }

  Future<void> deletarConsumo(int id) {
    if (fonteAtual == FontePersistencia.local) {
      return _database.deletarConsumo(id);
    }

    return _service.deletarConsumo(id);
  }
}
