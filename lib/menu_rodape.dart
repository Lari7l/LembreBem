import 'package:flutter/material.dart';

// Nessa tela fica o menu de rodapé, deixei ela separado
// pra ficar fácil de puxar no código

class MenuRodape extends StatelessWidget {
  final IconData icon;
  final String opcao;
  final bool selecionado;
  final VoidCallback onTap;

  const MenuRodape({
    required this.icon,
    required this.opcao,
    required this.selecionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selecionado)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xFF55C2C3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    opcao,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                Icon(icon, color: Color(0xFF55C2C3)),
                SizedBox(height: 4),
                Text(
                  opcao,
                  style: TextStyle(
                    color: Color(0xFF55C2C3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}