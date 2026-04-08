import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  
  static const _tituloAppBar = 'Criando Transferência';
  static const _rotuloCampoValor = 'Valor';
  static const _dicaCampoValor = '0.00';

  static const _rotuloCampoNumeroConta = 'Número Conta';
  static const _dicaCampoNumeroConta = '0000';
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
              controlador: widget._controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),

            Editor(
              controlador: widget._controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),

            ElevatedButton(
              child: Text(_textBotaoConfirmar),
              onPressed: () {
                debugPrint("Clicou no Confirmar!");
                _criaTransferencia(
                  context,
                  widget._controladorCampoNumeroConta,
                  widget._controladorCampoValor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _criaTransferencia(
  BuildContext context,
  TextEditingController controladorCampoNumeroConta,
  TextEditingController controladorCampoValor,
) {
  final int? numeroConta = int.parse(controladorCampoNumeroConta.text);
  final double? valor = double.parse(controladorCampoValor.text);

  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);
    debugPrint("Criando Transferência...");
    debugPrint("$transferenciaCriada");
    Navigator.pop(context, transferenciaCriada);
  }
}