class ConsumoAgua {
  final String atividade;
  final double litros;
  final String horario;

  ConsumoAgua({
    required this.atividade,
    required this.litros,
    required this.horario,
  });

  @override
  String toString() {
    return 'ConsumoAgua{atividade: $atividade, litros: $litros, horario: $horario}';
  }
}
