import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/screens/agregar_notas_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class NotasScreen extends StatefulWidget {
  const NotasScreen({Key? key}) : super(key: key);

  @override
  _NotasScrennState createState() => _NotasScrennState();
}

class _NotasScrennState extends State<NotasScreen> {
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSetting.colorPrimary,
        title: Text('Gestion de notas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/AgregarNota');
            },
            icon: Icon(Icons.note_add),
          )
        ],
      ),
      body: FutureBuilder(
          future: _databaseHelper.getAllNotes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NotasModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _ListadoNotas(snapshot.data!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget _ListadoNotas(List<NotasModel> notas) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          NotasModel nota = notas[index];
          return Card(
              child: Column(
            children: [
              Text(nota.titulo!, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(nota.detalle!),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarNotaScreen(
                                    nota: nota,
                                  )));
                    },
                    icon: Icon(Icons.edit),
                    iconSize: 15,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text('Eliminar nota'),
                                content:
                                    Text('¿Esta seguro de eliminar la nota?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _databaseHelper
                                          .delete(nota.id!)
                                          .then((noRows) {
                                        if (noRows > 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Nota eliminada')),
                                          );
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Text('Si'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),
                                ]);
                          });
                    },
                    icon: Icon(Icons.delete),
                    iconSize: 15,
                  ),
                ],
              )
            ],
          ));
        },
        itemCount: notas.length,
      ),
    );
  }
}
