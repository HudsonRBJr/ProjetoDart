import 'package:flutter/material.dart';

import '../../models/consumo_agua.dart';
import '../../repository/consumo_agua_repository.dart';
import 'formulario.dart';

class ListaConsumos extends StatefulWidget {
  final FontePersistencia fonteInicial;

  const ListaConsumos({
    super.key,
    this.fonteInicial = FontePersistencia.local,
  });

  @override
  State<ListaConsumos> createState() => _ListaConsumosState();
}

class _ListaConsumosState extends State<ListaConsumos> {
  late final ConsumoAguaRepository _repository;
  List<ConsumoAgua> _consumos = <ConsumoAgua>[];
  bool _carregando = false;

  @override
  void initState() {
    super.initState();
    _repository = ConsumoAguaRepository(fonteAtual: widget.fonteInicial);
    _carregarConsumos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de Água'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Atualizar lista',
            icon: const Icon(Icons.refresh),
            onPressed: _carregarConsumos,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _SeletorFonte(
            fonteAtual: _repository.fonteAtual,
            aoSelecionar: _alterarFonte,
          ),
          Expanded(
            child: _construirConteudo(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormularioCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _construirConteudo() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_consumos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Nenhum consumo cadastrado em ${_repository.fonteAtual.descricao}.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _consumos.length,
      itemBuilder: (BuildContext context, int indice) {
        final ConsumoAgua consumo = _consumos[indice];
        return ItemConsumo(
          consumo: consumo,
          aoEditar: () => _abrirFormularioEdicao(consumo),
          aoExcluir: () => _confirmarExclusao(consumo),
        );
      },
    );
  }

  Future<void> _carregarConsumos() async {
    setState(() => _carregando = true);

    try {
      final List<ConsumoAgua> consumos = await _repository.listarConsumos();
      if (!mounted) return;
      setState(() {
        _consumos = consumos;
        _carregando = false;
      });
    } catch (erro) {
      if (!mounted) return;
      setState(() => _carregando = false);
      _mostrarMensagem('Erro ao carregar dados: $erro');
    }
  }

  Future<void> _alterarFonte(FontePersistencia fonte) async {
    setState(() => _repository.fonteAtual = fonte);
    await _carregarConsumos();
  }

  Future<void> _abrirFormularioCadastro() async {
    final ConsumoAgua? consumo = await Navigator.push<ConsumoAgua>(
      context,
      MaterialPageRoute<ConsumoAgua>(
        builder: (_) => const FormularioConsumo(),
      ),
    );

    if (consumo == null) return;

    try {
      await _repository.salvarConsumo(consumo);
      await _carregarConsumos();
      _mostrarMensagem('Consumo cadastrado com sucesso.');
    } catch (erro) {
      _mostrarMensagem('Erro ao cadastrar consumo: $erro');
    }
  }

  Future<void> _abrirFormularioEdicao(ConsumoAgua consumo) async {
    final ConsumoAgua? consumoEditado = await Navigator.push<ConsumoAgua>(
      context,
      MaterialPageRoute<ConsumoAgua>(
        builder: (_) => FormularioConsumo(consumo: consumo),
      ),
    );

    if (consumoEditado == null) return;

    try {
      await _repository.atualizarConsumo(consumoEditado);
      await _carregarConsumos();
      _mostrarMensagem('Consumo atualizado com sucesso.');
    } catch (erro) {
      _mostrarMensagem('Erro ao atualizar consumo: $erro');
    }
  }

  Future<void> _confirmarExclusao(ConsumoAgua consumo) async {
    final bool? confirmou = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir consumo'),
          content: Text('Deseja excluir "${consumo.atividade}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmou != true || consumo.id == null) return;

    try {
      await _repository.deletarConsumo(consumo.id!);
      await _carregarConsumos();
      _mostrarMensagem('Consumo excluído com sucesso.');
    } catch (erro) {
      _mostrarMensagem('Erro ao excluir consumo: $erro');
    }
  }

  void _mostrarMensagem(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }
}

class _SeletorFonte extends StatelessWidget {
  final FontePersistencia fonteAtual;
  final ValueChanged<FontePersistencia> aoSelecionar;

  const _SeletorFonte({
    required this.fonteAtual,
    required this.aoSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SegmentedButton<FontePersistencia>(
        segments: const <ButtonSegment<FontePersistencia>>[
          ButtonSegment<FontePersistencia>(
            value: FontePersistencia.local,
            icon: Icon(Icons.storage),
            label: Text('Local'),
          ),
          ButtonSegment<FontePersistencia>(
            value: FontePersistencia.remota,
            icon: Icon(Icons.cloud),
            label: Text('Remoto'),
          ),
        ],
        selected: <FontePersistencia>{fonteAtual},
        onSelectionChanged: (Set<FontePersistencia> selecao) {
          aoSelecionar(selecao.first);
        },
      ),
    );
  }
}

class ItemConsumo extends StatelessWidget {
  final ConsumoAgua consumo;
  final VoidCallback aoEditar;
  final VoidCallback aoExcluir;

  const ItemConsumo({
    super.key,
    required this.consumo,
    required this.aoEditar,
    required this.aoExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.water_drop),
        title: Text('${consumo.atividade} - ${consumo.litros.toStringAsFixed(2)} L'),
        subtitle: Text('Horário: ${consumo.horario}'),
        trailing: Wrap(
          spacing: 4,
          children: <Widget>[
            IconButton(
              tooltip: 'Editar',
              icon: const Icon(Icons.edit),
              onPressed: aoEditar,
            ),
            IconButton(
              tooltip: 'Excluir',
              icon: const Icon(Icons.delete),
              onPressed: aoExcluir,
            ),
          ],
        ),
      ),
    );
  }
}
