import 'package:flutter/material.dart';

class TelaMenu extends StatelessWidget {
  final String emailTel;
  final String senha;

  // essas são as infos q eu preciso na tela de login
  // pra fazer a validação e navegar pra essa tela
  TelaMenu({
    required this.emailTel,
    required this.senha
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

    );
  }
}