import 'package:flutter/material.dart';
import 'package:lembrebem/botoes.dart';
import 'tela_menu.dart';

class TelaCadastro3 extends StatefulWidget {
  @override
  _TelaCadastro3State createState() => _TelaCadastro3State();
}

class _TelaCadastro3State extends State<TelaCadastro3> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  bool cadastrarDepois = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(24.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  SizedBox(height: 60),

                  Image.asset(
                    'assets/images/logo_lembrebem.png',
                    height: 200,
                  ),

                  SizedBox(height: 30),

                  Text(
                    'Passo 3: Contatos.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Adicione um contato de confiança\nque será notificado em caso de emergência.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 30),

                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7F7F7),
                    ),
                  ),

                  SizedBox(height: 16),

                  TextField(
                    controller: telefoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Número de telefone',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF7F7F7),
                    ),
                  ),

                  SizedBox(height: 24),

                  CheckboxListTile(
                    value: cadastrarDepois,
                    onChanged: (value) {
                      setState(() {
                        cadastrarDepois = value!;
                      });
                    },
                    title: Text('Cadastrar contato mais tarde'),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.teal,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Botão para finalizar o cadastro
                  BotaoPersonalizado(
                    texto: 'Finalizar cadastro',
                    cor: Color(0xFF55C2C3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaMenu()),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
            ),
        );
    }
}