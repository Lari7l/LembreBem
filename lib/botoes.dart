import 'package:flutter/material.dart';

class BotaoPersonalizado extends StatelessWidget {
  final String texto;
  final Color cor;
  final IconData? icone;
  final VoidCallback onPressed;

  const BotaoPersonalizado({
    required this.texto,
    required this.cor,
    this.icone,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                texto,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              if (icone != null) ...[
                SizedBox(width: 10),
                Icon(icone, color: Colors.white),
                SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}