import 'package:flutter/material.dart';

import '../repository/consumo_agua_repository.dart';
import 'consumo_agua/lista.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String _titulo = 'Controle de Consumo de Água';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Icon(Icons.water_drop, size: 48),
                    SizedBox(height: 12),
                    Text(
                      'Dashboard de consumo',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cadastre atividades, acompanhe os litros consumidos e escolha se os dados serão salvos localmente ou na API remota.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.storage),
              label: const Text('Abrir lista com SQLite local'),
              onPressed: () => _abrirLista(context, FontePersistencia.local),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.cloud),
              label: const Text('Abrir lista com API Render/PostgreSQL'),
              onPressed: () => _abrirLista(context, FontePersistencia.remota),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirLista(BuildContext context, FontePersistencia fonte) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ListaConsumos(fonteInicial: fonte),
      ),
    );
  }
}
