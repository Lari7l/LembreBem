import 'package:flutter/material.dart';
import 'telas/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LembreBem',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TelaInicial(),
    );
  }
}