import 'package:flutter/material.dart';
import 'tela_menu.dart';
import 'package:lembrebem/botoes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        builder:
            (context) => TelaMenu(
              emailTel: emailTelController.text,
              senha: senhaController.text,
            ),
      ),
    );
  }

  final supabase = Supabase.instance.client;

  Future<void> login(String email, String senha, BuildContext context) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: senha,
      );
      if (response.user != null) {
        print('Usuário autenticado!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaMenu(emailTel: email, senha: senha),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('Erro'),
                content: Text(
                  'Não foi possível autenticar. Verifique seu e-mail e senha.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Erro'),
              content: Text('Erro ao autenticar: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
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
                  Image.asset('assets/images/logo_lembrebem.png', height: 250),

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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await login(
                          emailTelController.text,
                          senhaController.text,
                          context,
                        );
                      }
                    },
                    child: Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
