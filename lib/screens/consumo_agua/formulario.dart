import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/consumo_agua.dart';

class FormularioConsumo extends StatefulWidget {
  final TextEditingController _controladorCampoAtividade =
      TextEditingController();
  final TextEditingController _controladorCampoLitros = TextEditingController();
  final TextEditingController _controladorCampoHorario = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioConsumoState();
  }
}

class FormularioConsumoState extends State<FormularioConsumo> {
  
  static const _tituloAppBar = 'Novo Consumo de Água';
  static const _rotuloCampoAtividade = 'Atividade';
  static const _dicaCampoAtividade = 'Ex: Banho, Lavar louça';

  static const _rotuloCampoLitros = 'Litros';
  static const _dicaCampoLitros = '0.0';
  static const _rotuloCampoHorario = 'Horário';
  static const _dicaCampoHorario = 'HH:MM';
  static const _textBotaoConfirmar = 'Confirmar';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          // style: TextStyle(
          //   color: Colors.white70,
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        //backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: widget._controladorCampoAtividade,
              rotulo: _rotuloCampoAtividade,
              dica: _dicaCampoAtividade,
            ),
            Editor(
              controlador: widget._controladorCampoLitros,
              rotulo: _rotuloCampoLitros,
              dica: _dicaCampoLitros,
              icone: Icons.water_drop,
              tipoTeclado: TextInputType.number,
            ),
            Editor(
              controlador: widget._controladorCampoHorario,
              rotulo: _rotuloCampoHorario,
              dica: _dicaCampoHorario,
            ),

            ElevatedButton(
              child: Text(_textBotaoConfirmar),
              onPressed: () {
                debugPrint("Clicou no Confirmar!");
                _criaConsumo(
                  context,
                  widget._controladorCampoAtividade,
                  widget._controladorCampoLitros,
                  widget._controladorCampoHorario,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _criaConsumo(
  BuildContext context,
  TextEditingController controladorCampoAtividade,
  TextEditingController controladorCampoLitros,
  TextEditingController controladorCampoHorario,
) {
  final String atividade = controladorCampoAtividade.text;
  final double? litros = double.tryParse(controladorCampoLitros.text);
  final String horario = controladorCampoHorario.text;

  if (atividade.isNotEmpty && litros != null && horario.isNotEmpty) {
    final consumoCriado = ConsumoAgua(
      atividade: atividade,
      litros: litros,
      horario: horario,
    );
    debugPrint("Criando Consumo...");
    debugPrint("$consumoCriado");
    Navigator.pop(context, consumoCriado);
  }
}