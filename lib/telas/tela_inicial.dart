import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'tela_cadastro1.dart';
import 'package:lembrebem/botoes.dart';

class TelaInicial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(

        child: Center(

          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/images/logo_lembrebem.png',
                  height: 250,
                ),

                SizedBox(height: 32),

                Text(
                  'Gerencie os seus medicamentos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Tenha seus remédios no seu celular,'
                      '\nnunca mais se esqueça de tomá-los e'
                      '\ngerencie seu estoque.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 32),

                BotaoPersonalizado(
                    texto: 'Fazer cadastro',
                  cor: Color(0xFF55C2C3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        // e aqui to indo pra tela de cadastro
                        MaterialPageRoute(builder: (context) => TelaCadastro1()),
                      );
                    },
                ),

                SizedBox(height: 16),

                BotaoPersonalizado(
                  texto: 'Fazer login',
                  cor: Color(0xFF55C2C3),
                  onPressed: () {
                    Navigator.push(
                      context,
                      // e aqui to indo pra tela de login
                      MaterialPageRoute(builder: (context) => TelaLogin()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}