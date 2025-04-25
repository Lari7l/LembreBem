import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'tela_cadastro3.dart'; // importa a tela 3 aqui
import 'package:lembrebem/botoes.dart';


class TelaCadastro2 extends StatefulWidget {
  final Map<String, dynamic> dadosCadastro;

  TelaCadastro2({required this.dadosCadastro});

  @override
  _TelaCadastro2State createState() => _TelaCadastro2State();
}

class CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 5) {
      text = text.substring(0, 5) + '-' + text.substring(5);
    }
    if (text.length > 9) {
      text = text.substring(0, 9);
    }
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _TelaCadastro2State extends State<TelaCadastro2> {
  final _formKey = GlobalKey<FormState>();
  final telefoneController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final cepController = TextEditingController();

  String? estadoSelecionado;
  String? cidadeSelecionada;

  final Map<String, List<String>> estadosECidades = {
    'SP': ['São Paulo', 'Campinas', 'Santos'],
    'RJ': ['Rio de Janeiro', 'Niterói', 'Petópolis'],
    'MG': ['Belo Horizonte', 'Uberlândia', 'Contagem'],
    'RS': ['Porto Alegre', 'Caxias do Sul', 'Pelotas'],
    'PR': ['Cascavel', 'Corbélia', 'Toledo'],
  };

  final telefoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  void finalizarCadastro2() {
    if (_formKey.currentState!.validate()) {
      // Adiciona os dados desta tela ao mapa
      widget.dadosCadastro['telefone'] = telefoneController.text;
      widget.dadosCadastro['estado'] = estadoSelecionado;
      widget.dadosCadastro['cidade'] = cidadeSelecionada;
      widget.dadosCadastro['rua'] = ruaController.text;
      widget.dadosCadastro['numero'] = numeroController.text;
      widget.dadosCadastro['cep'] = cepController.text;

      // Navega para TelaCadastro3
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TelaCadastro3(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      'Passo 2: Endereço e Contato',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 30),

                  ],
                ),

                _buildTextField(
                  controller: telefoneController,
                  label: 'Telefone *',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [telefoneFormatter],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo é obrigatório.';
                    }
                    if (telefoneFormatter.getUnmaskedText().length != 11) {
                      return 'Digite um telefone válido.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Estado *'),
                  value: estadoSelecionado,
                  items: estadosECidades.keys.map((String estado) {
                    return DropdownMenuItem<String>(
                      value: estado,
                      child: Text(estado),
                    );
                  }).toList(),
                  onChanged: (String? novoEstado) {
                    setState(() {
                      estadoSelecionado = novoEstado;
                      cidadeSelecionada = null;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Selecione um estado.' : null,
                ),

                SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Cidade *'),
                  value: cidadeSelecionada,
                  items: estadoSelecionado == null
                      ? []
                      : estadosECidades[estadoSelecionado]!
                      .map((String cidade) {
                    return DropdownMenuItem<String>(
                      value: cidade,
                      child: Text(cidade),
                    );
                  }).toList(),
                  onChanged: (String? novaCidade) {
                    setState(() {
                      cidadeSelecionada = novaCidade;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Selecione uma cidade.' : null,
                ),

                SizedBox(height: 12),

                _buildTextField(
                  controller: ruaController,
                  label: 'Rua *',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo é obrigatório.';
                    }
                    if (!RegExp(r"^[a-zA-ZÀ-ÿ\s]+$").hasMatch(value)) {
                      return 'Digite apenas letras.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: numeroController,
                        label: 'Número *',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo é obrigatório.';
                          }
                          if (!RegExp(r"^\d+$").hasMatch(value)) {
                            return 'Digite apenas números.';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(width: 16),

                    Expanded(
                      child: _buildTextField(
                        controller: cepController,
                        label: 'CEP *',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo é obrigatório.';
                          }
                          if (!RegExp(r"^\d{5}-\d{3}$").hasMatch(value)) {
                            return 'Digite um CEP válido (xxxxx-xxx).';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                BotaoPersonalizado(
                  texto: 'Próximo',
                  cor: Color(0xFF55C2C3),
                  onPressed: finalizarCadastro2
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Color(0xFFF8F8F8),
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
      decoration: _inputDecoration(label),
      validator: validator,
    );
  }
}
