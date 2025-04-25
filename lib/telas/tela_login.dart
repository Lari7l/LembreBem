import 'package:flutter/material.dart';
import 'tela_menu.dart';
import 'package:lembrebem/botoes.dart';

class TelaLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final emailTelController = TextEditingController();
  final senhaController = TextEditingController();

  // essa é a função que eu fiz pra navegar pra tela de menu
  // (as informações 'emailTel' e 'senha' são obrigatórias
  // pra ir pra outra tela)
  void telaMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaMenu(
          emailTel: emailTelController.text,
          senha: senhaController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(

        child: Center(

          child: Padding(
            padding: const EdgeInsets.all(24.0),

            child: Form(
              key: _formKey,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image.asset(
                    'assets/images/logo_lembrebem.png',
                    height: 250,
                  ),

                  SizedBox(height: 32),

                  Text(
                    'Bem vindo!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    controller: emailTelController,
                    decoration: InputDecoration(
                      labelText: 'Email ou Telefone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                    ),
                    // a parte de validação fica aqui
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 12),

                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 32),

                  BotaoPersonalizado(
                    texto: 'Login',
                    cor: Color(0xFF55C2C3),
                    onPressed: () {
                      // aqui faz a confirmação q tenho todas as infos
                      // necessárias, e depois navega pra tela de menu
                      if (_formKey.currentState!.validate()) {
                        telaMenu(context);
                      }
                    },
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}