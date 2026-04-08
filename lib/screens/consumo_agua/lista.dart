import 'package:flutter/material.dart';
import 'formulario.dart';
import '../../models/consumo_agua.dart';

class ListaConsumos extends StatefulWidget {
  final List<ConsumoAgua> _consumos = [];
  @override
  State<StatefulWidget> createState() {
    return ListaConsumosState();
  }
}

class ListaConsumosState extends State<ListaConsumos> {
  static const _tituloAppBar = 'Consumo de Água';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      ),

      body: ListView.builder(
        itemCount: widget._consumos.length,
        itemBuilder: (context, indice) {
          final consumo = widget._consumos[indice];
          return ItemConsumo(consumo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Botão + Pressionado!");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioConsumo();
              },
            ),
          ).then((consumoRecebido) => _atualiza(consumoRecebido));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _atualiza(ConsumoAgua? consumoRecebido) {
    if (consumoRecebido != null) {
      setState(() {
        widget._consumos.add(consumoRecebido);
      });
    }
  }
}

class ItemConsumo extends StatelessWidget {
  final ConsumoAgua _consumo;

  ItemConsumo(this._consumo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.water_drop),
        title: Text('${_consumo.atividade} - ${_consumo.litros} L'),
        subtitle: Text(_consumo.horario),
      ),
    );
  }
}
