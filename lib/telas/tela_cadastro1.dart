import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela_cadastro2.dart';
import 'package:lembrebem/botoes.dart';

// Formatadores
class DataNascimentoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length >= 3 && text.length <= 4) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    } else if (text.length > 4) {
      text = text.substring(0, 2) +
          '/' +
          text.substring(2, 4) +
          '/' +
          text.substring(4);
    }

    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length >= 4 && text.length <= 6) {
      text = text.substring(0, 3) + '.' + text.substring(3);
    } else if (text.length >= 7 && text.length <= 9) {
      text = text.substring(0, 3) +
          '.' +
          text.substring(3, 6) +
          '.' +
          text.substring(6);
    } else if (text.length > 9) {
      text = text.substring(0, 3) +
          '.' +
          text.substring(3, 6) +
          '.' +
          text.substring(6, 9) +
          '-' +
          text.substring(9);
    }

    if (text.length > 14) {
      text = text.substring(0, 14);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class TelaCadastro1 extends StatefulWidget {
  @override
  State<TelaCadastro1> createState() => _TelaCadastro1State();
}

class _TelaCadastro1State extends State<TelaCadastro1> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final senhaController = TextEditingController();
  bool mostrarSenha = false;

  void avancarCadastro(BuildContext context) {
    final dadosCadastro = {
      'nome': nomeController.text,
      'cpf': cpfController.text,
      'email': emailController.text,
      'dataNascimento': dataNascimentoController.text,
      'senha': senhaController.text,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCadastro2(dadosCadastro: dadosCadastro),
      ),
    );
  }

  bool validarMinimo(String senha) => senha.length >= 8;
  bool validarMaiuscula(String senha) => senha.contains(RegExp(r'[A-Z]'));
  bool validarMinuscula(String senha) => senha.contains(RegExp(r'[a-z]'));
  bool validarNumero(String senha) => senha.contains(RegExp(r'[0-9]'));

  Widget _criterio(String texto, bool valido) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          valido ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: valido ? Colors.green : Colors.red,
        ),
        SizedBox(width: 4),
        Text(texto, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final senha = senhaController.text;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_lembrebem.png',
                      height: 200,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Passo 1: Suas informações',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                _buildTextField(
                  controller: nomeController,
                  label: 'Nome completo *',
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Este campo é obrigatório.';
                    if (!RegExp(r"^[a-zA-ZÀ-ÿ\s]+$").hasMatch(value))
                      return 'Digite um nome válido.';
                    return null;
                  },
                ),
                SizedBox(height: 12),
                _buildTextField(
                  controller: cpfController,
                  label: 'CPF *',
                  keyboardType: TextInputType.number,
                  inputFormatters: [CpfInputFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Este campo é obrigatório.';
                    String cpf = value.replaceAll(RegExp(r'[^0-9]'), '');
                    if (cpf.length != 11)
                      return 'Digite um CPF válido (11 números).';
                    return null;
                  },
                ),
                SizedBox(height: 12),
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value)) {
                      return 'Digite um email válido.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                _buildTextField(
                  controller: dataNascimentoController,
                  label: 'Data de nascimento *',
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [DataNascimentoInputFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Este campo é obrigatório.';
                    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value))
                      return 'Digite uma data válida (dd/mm/aaaa).';
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: senhaController,
                  obscureText: !mostrarSenha,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Senha *',
                    suffixIcon: IconButton(
                      icon: Icon(mostrarSenha
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => mostrarSenha = !mostrarSenha),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Este campo é obrigatório.';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _criterio('✔ 8 caracteres', validarMinimo(senha)),
                    _criterio('✔ Maiúscula', validarMaiuscula(senha)),
                    _criterio('✔ Minúscula', validarMinuscula(senha)),
                    _criterio('✔ Número', validarNumero(senha)),
                  ],
                ),
                SizedBox(height: 30),
                BotaoPersonalizado(
                  texto: 'Próximo',
                  cor: Color(0xFF55C2C3),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      avancarCadastro(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Color(0xFFF8F8F8),
        filled: true,
      ),
      validator: validator,
    );
  }
}
