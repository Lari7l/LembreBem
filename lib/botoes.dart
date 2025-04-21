import 'package:flutter/material.dart';

// Nessa tela fica o design dos botões, deixei separado
// pra ficar fácil de puxar no código

class BotaoPersonalizado extends StatelessWidget {
  final String texto;
  final Color cor;
  final VoidCallback onPressed;

  const BotaoPersonalizado({
    required this.texto,
    required this.cor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            texto,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}