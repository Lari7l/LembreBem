import 'package:flutter/material.dart';
import 'tela_menu.dart';

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

                      // muda a cor da borda padrão
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFAFAFAF), width: 1.5),
                      ),

                      // muda a cor da borda quando é clicada
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFAFAFAF), width: 2),
                      ),

                      // muda a cor da borda quando da erro (campo vazio)
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),

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

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFAFAFAF), width: 1.5),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFAFAFAF), width: 2),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // aqui faz a confirmação q tenho todas as infos
                        // necessárias, e depois navega pra tela de menu
                        if (_formKey.currentState!.validate()) {
                          telaMenu(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF55C2C3),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
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