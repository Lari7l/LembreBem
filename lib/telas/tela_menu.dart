import 'package:flutter/material.dart';
import 'package:lembrebem/botoes.dart';
import 'package:lembrebem/menu_rodape.dart';
import 'tela_alarme.dart';

class TelaMenu extends StatelessWidget {
  final String emailTel;
  final String senha;

  TelaMenu({
    required this.emailTel,
    required this.senha,
  });

  // Função para navegar entre as telas
  void navegar(BuildContext context, String rota) {
    if (rota != '/menu') {
      Navigator.pushNamed(context, rota);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(

        child: Column(

          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),

                child: Column(
                  children: [
                    SizedBox(height: 15),

                    Image.asset(
                      'assets/images/menu_lembrebem.png',
                      height: 150,
                    ),

                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF55C2C3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 30),

                    Text(
                      'O que gostaria de fazer hoje?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF464646),
                      ),
                    ),

                    SizedBox(height: 32),

                    BotaoPersonalizado(
                      texto: 'Emergência',
                      cor: Color(0xFFE32826),
                      onPressed: () {},
                    ),

                    SizedBox(height: 16),

                    BotaoPersonalizado(
                      texto: 'Meus Medicamentos',
                      cor: Color(0xFF55C2C3),
                      onPressed: () {},
                    ),

                    SizedBox(height: 16),

                    BotaoPersonalizado(
                      texto: 'Receitas',
                      cor: Color(0xFF55C2C3),
                      onPressed: () {},
                    ),

                    SizedBox(height: 16),

                    BotaoPersonalizado(
                      texto: 'Acessibilidade',
                      cor: Color(0xFF55C2C3),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Rodapé com navegação
            Container(
              color: Color(0xFFEFF9FB),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuRodape(
                    icon: Icons.search,
                    opcao: 'Pesquisar',
                    selecionado: false,
                    onTap: () {},
                  ),
                  MenuRodape(
                    icon: Icons.alarm,
                    opcao: 'Alarme',
                    selecionado: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaAlarme()),
                      );
                    },
                  ),
                  MenuRodape(
                    icon: Icons.person,
                    opcao: 'Perfil',
                    selecionado: false,
                    onTap: () {},
                  ),
                  MenuRodape(
                    icon: Icons.home,
                    opcao: 'Menu',
                    selecionado: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}