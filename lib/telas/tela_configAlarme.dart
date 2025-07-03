import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lembrebem/modelo_alarme.dart';
import 'tela_alarme.dart';
import 'tela_menu.dart';
import 'package:lembrebem/botoes.dart';
import 'package:lembrebem/menu_rodape.dart';

class TelaConfigAlarme extends StatefulWidget {
  final Alarme? alarme;
  TelaConfigAlarme({this.alarme});

  @override
  _TelaConfigAlarmeState createState() => _TelaConfigAlarmeState();
}

class _TelaConfigAlarmeState extends State<TelaConfigAlarme> {
  String? _selectedInterval;
  String? _selectedUso;
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _medicamentoController = TextEditingController();
  TextEditingController _observacoesController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF55C2C3)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.alarme != null) {
      _medicamentoController.text = widget.alarme!.nome;
      _observacoesController.text = widget.alarme!.observacoes;
      _selectedTime = widget.alarme!.horario;

      final intervalos = ['8 em 8h', '6 em 6h', '12 em 12h'];
      final diasUso = ['3 dias', '7 dias', 'Uso contínuo'];

      _selectedInterval =
          intervalos.contains(widget.alarme!.intervalo)
              ? widget.alarme!.intervalo
              : null;

      _selectedUso =
          diasUso.contains(widget.alarme!.diasDeUso)
              ? widget.alarme!.diasDeUso
              : null;
    }
  }

  void _salvarAlarme() {
    Navigator.pop(
      context,
      Alarme(
        id: widget.alarme?.id ?? '',
        nome: _medicamentoController.text,
        observacoes: _observacoesController.text,
        horario: _selectedTime,
        diasDeUso: _selectedUso ?? '',
        ativado: true,
        intervalo: _selectedInterval ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF55C2C3)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Adicionar alarme', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Text(
                'Horário da medicação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 35),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedTime.hour.toString().padLeft(2, '0'),
                        style: TextStyle(fontSize: 36),
                      ),
                      SizedBox(width: 8),
                      Text(':', style: TextStyle(fontSize: 36)),
                      SizedBox(width: 8),
                      Text(
                        _selectedTime.minute.toString().padLeft(2, '0'),
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Nome do Medicamento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _medicamentoController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do medicamento...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Intervalos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedInterval ?? '8 em 8h',
                decoration: InputDecoration(border: InputBorder.none),
                isExpanded: true,
                items:
                    ['8 em 8h', '6 em 6h', '12 em 12h'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged:
                    (newValue) => setState(() => _selectedInterval = newValue),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Dias de uso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedUso ?? '3 dias',
                decoration: InputDecoration(border: InputBorder.none),
                isExpanded: true,
                items:
                    ['3 dias', '7 dias', 'Uso contínuo'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged:
                    (newValue) => setState(() => _selectedUso = newValue),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Observações',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _observacoesController,
                decoration: InputDecoration(
                  hintText:
                      'Digite orientações importantes para o uso correto do medicamento...',
                  border: InputBorder.none,
                ),
                maxLines: 4,
              ),
            ),

            SizedBox(height: 24),

            Center(
              child: BotaoPersonalizado(
                texto: 'Salvar alarme',
                cor: Color(0xFF55C2C3),
                onPressed: _salvarAlarme,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Color(0xFFEFF9FB),
        padding: EdgeInsets.symmetric(vertical: 10),
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
              selecionado: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TelaAlarme()),
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
              selecionado: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TelaMenu()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
