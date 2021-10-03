import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones Implicitas'),
        backgroundColor: ColorSetting.colorPrimary,
      ),
      body: ListView(children: [
        Card(
          elevation: 8.0,
          shadowColor: Colors.black,
          child: ListTile(
              tileColor: Colors.white30,
              title: Text('Abrir pagina web'),
              subtitle: Row(children: [
                Icon(Icons.touch_app_rounded,
                    size: 18, color: Colors.redAccent),
                Text('www.google.com'),
              ]),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.language, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb),
        ),
        Card(
          elevation: 8.0,
          shadowColor: Colors.black,
          child: ListTile(
              tileColor: Colors.white30,
              title: Text('Llamada telefonica'),
              subtitle: Row(children: [
                Icon(Icons.touch_app_rounded,
                    size: 18, color: Colors.redAccent),
                Text('Cel: 4612641228'),
              ]),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.phone_android, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica),
        ),
        Card(
          elevation: 8.0,
          shadowColor: Colors.black,
          child: ListTile(
              tileColor: Colors.white30,
              title: Text('Enviar SMS'),
              subtitle: Row(children: [
                Icon(Icons.touch_app_rounded,
                    size: 18, color: Colors.redAccent),
                Text('Cel: 4612641228'),
              ]),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.sms_sharp, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS),
        ),
        Card(
          elevation: 8.0,
          shadowColor: Colors.black,
          child: ListTile(
              tileColor: Colors.white30,
              title: Text('Enviar email'),
              subtitle: Row(children: [
                Icon(Icons.touch_app_rounded,
                    size: 18, color: Colors.redAccent),
                Text('To: 17030634@itcelaya.edu.mx'),
              ]),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.email_outlined, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail),
        ),
        Card(
          elevation: 8.0,
          shadowColor: Colors.black,
          child: ListTile(
              tileColor: Colors.white30,
              title: Text('Sonrie :)'),
              subtitle: Row(children: [
                Icon(Icons.touch_app_rounded,
                    size: 18, color: Colors.redAccent),
                Text('To: 17030634@itcelaya.edu.mx'),
              ]),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb),
        ),
      ]),
    );
  }

  _abrirWeb() async {
    const url = 'https://www.google.com';
    await canLaunch(url) ? launch(url) : print('No se pudo abrir');
  }

  _llamadaTelefonica() async {
    const target = 'tel:4612641228';
    await canLaunch(target) ? launch(target) : print('No se pudo abrir');
  }

  _enviarSMS() async {
    const target = 'sms:4612641228';
    await canLaunch(target) ? launch(target) : print('No se pudo abrir');
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '17030634@itcelaya.edu.mx',
        query: 'subject=Saludos&body=Bienvenido :)');

    var email = params.toString();
    await canLaunch(email) ? launch(email) : print('No se pudo abrir');
  }

  _tomarFoto() async {}
}
