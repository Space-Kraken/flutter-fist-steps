import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotasScreenState createState() => _AgregarNotasScreenState();
}

class _AgregarNotasScreenState extends State<AgregarNotaScreen> {
  late DatabaseHelper _databaseHelper;
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {
    if (widget.nota != null) {
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
    }

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSetting.colorPrimary,
          title:
              widget.nota == null ? Text('Agregar Nota') : Text('Editar Nota'),
        ),
        body: ListView(children: [
          SizedBox(height: 15),
          _createTextFieldTitulo(),
          SizedBox(height: 10),
          _createTextFieldDetalle(),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                if (widget.nota == null) {
                  NotasModel nota = NotasModel(
                    titulo: _controllerTitulo.text,
                    detalle: _controllerDetalle.text,
                  );
                  _databaseHelper.insert(nota.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content: Text('Registro insertado correctamente')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("La solicitud no se completo")));
                    }
                  });
                } else {
                  NotasModel nota = NotasModel(
                    id: widget.nota!.id,
                    titulo: _controllerTitulo.text,
                    detalle: _controllerDetalle.text,
                  );
                  _databaseHelper.update(nota.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("La solicitud no se completo")));
                    }
                  });
                }
              },
              child: Text("Guardar Notas"))
        ]));
  }

  Widget _createTextFieldTitulo() {
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Titulo de la nota',
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value) {},
    );
  }

  Widget _createTextFieldDetalle() {
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: 'Detalle de la nota',
        errorText: "Este campo es obligatorio",
      ),
      onChanged: (value) {},
    );
  }
}
