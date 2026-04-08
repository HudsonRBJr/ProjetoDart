import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  final TextInputType? tipoTeclado;

  const Editor({
    super.key,
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
    this.tipoTeclado,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controlador,
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          prefixIcon: icone != null ? Icon(icone) : null,
        ),
      ),
    );
  }
}
