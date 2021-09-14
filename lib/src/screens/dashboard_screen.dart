import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSetting.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ernesto Cano Perez'),
            accountEmail: Text('ernestocanop@hotmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i1.sndcdn.com/avatars-000277791372-m87638-t500x500.jpg'),
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: ColorSetting.colorPrimary,
            ),
          ),
          ListTile(
            title: Text('Practica 1'),
            subtitle: Text('Descripcion corta'),
            leading: Icon(Icons.monetization_on_outlined),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/opc1');
            },
          ),
          ListTile(
            title: Text('Practica 2'),
            subtitle: Text('Descripcion corta'),
            leading: Icon(Icons.thermostat),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}
