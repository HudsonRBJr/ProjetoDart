import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/consumo_agua.dart';

class ConsumoAguaService {
  static const String _baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://sua-api-controle-agua.onrender.com',
  );

  Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  Future<List<ConsumoAgua>> listarConsumos() async {
    final http.Response response = await http.get(_uri('/consumos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((dynamic item) => ConsumoAgua.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Erro ao buscar dados da API: ${response.statusCode}');
  }

  Future<ConsumoAgua> cadastrarConsumo(ConsumoAgua consumo) async {
    final http.Response response = await http.post(
      _uri('/consumos'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(consumo.toJson()),
    );

    if (response.statusCode == 201) {
      return ConsumoAgua.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw Exception('Erro ao cadastrar na API: ${response.statusCode}');
  }

  Future<ConsumoAgua> atualizarConsumo(ConsumoAgua consumo) async {
    if (consumo.id == null) {
      throw Exception('Não foi possível atualizar na API: consumo sem id.');
    }

    final http.Response response = await http.put(
      _uri('/consumos/${consumo.id}'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(consumo.toJson()),
    );

    if (response.statusCode == 200) {
      return ConsumoAgua.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    throw Exception('Erro ao atualizar na API: ${response.statusCode}');
  }

  Future<void> deletarConsumo(int id) async {
    final http.Response response = await http.delete(_uri('/consumos/$id'));

    if (response.statusCode != 204) {
      throw Exception('Erro ao deletar na API: ${response.statusCode}');
    }
  }
}
