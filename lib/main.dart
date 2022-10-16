import 'package:flutter/material.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screens/details_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/agregar_notas_screen.dart';
import 'package:practica2/src/widgets/video_player_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1'       : (BuildContext context) => opcion1Screen(),
        '/intenciones': (BuildContext context) => IntencionesScreen(),
        '/notas'      : (BuildContext context) => NotasScreen(),
        '/AgregarNota': (BuildContext context) => AgregarNotaScreen(),
        '/Profile'    : (BuildContext context) => ProfileScreen(),
        '/movie'      : (BuildContext context) => PopularScreen(),
        '/details'    : (BuildContext context) => DetailsScreen(),
        '/player'    : (BuildContext context) => VideoPlayerWidget(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
