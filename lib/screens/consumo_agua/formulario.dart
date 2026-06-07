import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../../models/consumo_agua.dart';

class FormularioConsumo extends StatefulWidget {
  final ConsumoAgua? consumo;

  const FormularioConsumo({super.key, this.consumo});

  @override
  State<FormularioConsumo> createState() => _FormularioConsumoState();
}

class _FormularioConsumoState extends State<FormularioConsumo> {
  static const String _rotuloCampoAtividade = 'Atividade';
  static const String _dicaCampoAtividade = 'Ex: Banho, lavar louça';
  static const String _rotuloCampoLitros = 'Litros';
  static const String _dicaCampoLitros = '0.0';
  static const String _rotuloCampoHorario = 'Horário';
  static const String _dicaCampoHorario = 'HH:MM';

  late final TextEditingController _controladorCampoAtividade;
  late final TextEditingController _controladorCampoLitros;
  late final TextEditingController _controladorCampoHorario;

  bool get _editando => widget.consumo != null;

  @override
  void initState() {
    super.initState();
    _controladorCampoAtividade = TextEditingController(
      text: widget.consumo?.atividade ?? '',
    );
    _controladorCampoLitros = TextEditingController(
      text: widget.consumo?.litros.toString() ?? '',
    );
    _controladorCampoHorario = TextEditingController(
      text: widget.consumo?.horario ?? '',
    );
  }

  @override
  void dispose() {
    _controladorCampoAtividade.dispose();
    _controladorCampoLitros.dispose();
    _controladorCampoHorario.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar consumo de água' : 'Novo consumo de água'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 12),
            Editor(
              controlador: _controladorCampoAtividade,
              rotulo: _rotuloCampoAtividade,
              dica: _dicaCampoAtividade,
              icone: Icons.task_alt,
            ),
            Editor(
              controlador: _controladorCampoLitros,
              rotulo: _rotuloCampoLitros,
              dica: _dicaCampoLitros,
              icone: Icons.water_drop,
              tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
            ),
            Editor(
              controlador: _controladorCampoHorario,
              rotulo: _rotuloCampoHorario,
              dica: _dicaCampoHorario,
              icone: Icons.schedule,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: Icon(_editando ? Icons.save : Icons.add),
                label: Text(_editando ? 'Salvar alterações' : 'Cadastrar'),
                onPressed: _confirmar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmar() {
    final String atividade = _controladorCampoAtividade.text.trim();
    final String litrosTexto = _controladorCampoLitros.text.trim().replaceAll(',', '.');
    final double? litros = double.tryParse(litrosTexto);
    final String horario = _controladorCampoHorario.text.trim();

    if (atividade.isEmpty || litros == null || litros <= 0 || horario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha atividade, litros válidos e horário.'),
        ),
      );
      return;
    }

    final ConsumoAgua consumo = ConsumoAgua(
      id: widget.consumo?.id,
      atividade: atividade,
      litros: litros,
      horario: horario,
    );

    Navigator.pop(context, consumo);
  }
}
