class ConsumoAgua {
  final int? id;
  final String atividade;
  final double litros;
  final String horario;

  const ConsumoAgua({
    this.id,
    required this.atividade,
    required this.litros,
    required this.horario,
  });

  ConsumoAgua copyWith({
    int? id,
    String? atividade,
    double? litros,
    String? horario,
  }) {
    return ConsumoAgua(
      id: id ?? this.id,
      atividade: atividade ?? this.atividade,
      litros: litros ?? this.litros,
      horario: horario ?? this.horario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'atividade': atividade,
      'litros': litros,
      'horario': horario,
    };
  }

  factory ConsumoAgua.fromMap(Map<String, dynamic> map) {
    return ConsumoAgua(
      id: map['id'] is int ? map['id'] as int : int.tryParse('${map['id']}'),
      atividade: map['atividade']?.toString() ?? '',
      litros: map['litros'] is num
          ? (map['litros'] as num).toDouble()
          : double.tryParse('${map['litros']}') ?? 0,
      horario: map['horario']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'atividade': atividade,
      'litros': litros,
      'horario': horario,
    };
  }

  factory ConsumoAgua.fromJson(Map<String, dynamic> json) {
    return ConsumoAgua.fromMap(json);
  }

  @override
  String toString() {
    return 'ConsumoAgua{id: $id, atividade: $atividade, litros: $litros, horario: $horario}';
  }
}
