import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/profile_Model.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DatabaseHelper _databaseHelper;
  File? image;
  ProfileModel? data;
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelper.getUser(),
      builder: (BuildContext context, AsyncSnapshot<ProfileModel?> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text("Error"),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            // name = '${data!.name} ${data!.aPaterno} ${data!.aMaterno}';
            // email = data!.email;
            return Scaffold(
              appBar: AppBar(
                title: Text("DashBoard"),
                backgroundColor: ColorSetting.colorPrimary,
              ),
              drawer: Drawer(
                child: ListView(children: [
                  UserAccountsDrawerHeader(
                    accountName: snapshot.data != null
                        ? Text(
                            '${snapshot.data!.name} ${snapshot.data!.aPaterno} ${snapshot.data!.aMaterno}')
                        : Text("Uknow"),
                    accountEmail: snapshot.data != null
                        ? Text('${snapshot.data!.email}')
                        : Text("Uknow"),
                    arrowColor: Colors.white,
                    currentAccountPicture: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text('Practica 2 App'),
                                children: [
                                  SimpleDialogOption(
                                      child: const Text("Gestionar datos"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            profileData: snapshot
                                                                        .data !=
                                                                    null
                                                                ? snapshot.data!
                                                                : null)))
                                            .whenComplete(
                                                () => {setState(() {})});
                                      })
                                ],
                              );
                            });
                      },
                      child: CircleAvatar(
                        backgroundImage: snapshot.data != null
                            ? Image.file(new File('${snapshot.data!.image!}'))
                                .image
                            : null,
                        child: Icon(Icons.person),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ColorSetting.colorPrimary,
                    ),
                  ),
                  ListTile(
                    title: Text('Propinas'),
                    subtitle: Text('Calcula cuanto pagar'),
                    leading: Icon(Icons.monetization_on_outlined),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/opc1');
                    },
                  ),
                  ListTile(
                    title: Text('Intenciones'),
                    subtitle: Text('Intenciones implicitas'),
                    leading: Icon(Icons.phone_android),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/intenciones');
                    },
                  ),
                  ListTile(
                    title: Text('Notas'),
                    subtitle: Text('CRUD Notas'),
                    leading: Icon(Icons.note),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/notas');
                    },
                  ),
                  ListTile(
                    title: Text('Movies'),
                    subtitle: Text('Prueba API REST'),
                    leading: Icon(Icons.movie),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/movie');
                    },
                  ),
                ]),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
