import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica2/src/utils/color_settings.dart';

class opcion1Screen extends StatefulWidget {
  opcion1Screen({Key? key}) : super(key: key);

  @override
  _opcion1ScreenState createState() => _opcion1ScreenState();
}

class _opcion1ScreenState extends State<opcion1Screen> {
  final _actionResoult = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Form inputForm = Form(
        key: _actionResoult,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter an amount";
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^([0-9]+)?(?:\.[0-9]*)?$'))
              ],
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Ingrese el monto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: ColorSetting.colorButton),
              onPressed: () {
                if (_actionResoult.currentState!.validate()) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: Text('Resoult'),
                              content: Text(
                                  'The total amount is: ${(double.parse(amount.text) * 1.10).toStringAsFixed(3)}'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("I got it"))
                              ]));
                }
              },
              child: Text("Calculate Total Count Amount"),
            )
          ],
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de propinas'),
          backgroundColor: ColorSetting.colorPrimary,
        ),
        body: Center(
            child: Card(
          margin: EdgeInsets.all(20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                    "Ingrese un monto superior para calcular el total a pagar"),
                SizedBox(height: 20),
                inputForm,
                SizedBox(height: 20),
                Text("10% Calculated Tip"),
              ],
            ),
          ),
        )));
  }
}
