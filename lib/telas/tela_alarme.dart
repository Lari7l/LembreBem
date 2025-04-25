import 'package:flutter/material.dart';
import 'package:lembrebem/botoes.dart';
import 'package:lembrebem/menu_rodape.dart';
import 'package:lembrebem/telas/tela_configAlarme.dart';
import 'package:lembrebem/telas/tela_menu.dart';
import 'package:lembrebem/modelo_alarme.dart';

class TelaAlarme extends StatefulWidget {
  @override
  _TelaAlarmeState createState() => _TelaAlarmeState();
}

class _TelaAlarmeState extends State<TelaAlarme> {
  List<Alarme> alarmeList = [];

  Widget containerAlarme(Alarme alarme, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF55C2C3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarme.nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  alarme.horario.format(context),
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 4),
                Text(alarme.diasDeUso),
                if (alarme.observacoes.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      alarme.observacoes,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  alarme.ativado ? Icons.toggle_on : Icons.toggle_off,
                  color: alarme.ativado ? Color(0xFF55C2C3) : Colors.grey,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    alarme.ativado = !alarme.ativado;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red, size: 30),
                onPressed: () {
                  setState(() {
                    alarmeList.removeAt(index);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),

              child: Column(
                children: [
                  SizedBox(height: 15),

                  Text(
                    'Alarmes',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF55C2C3),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 32),

                  BotaoPersonalizado(
                    texto: 'Adicionar alarme',
                    cor: Color(0xFF55C2C3),
                    icone: Icons.add,
                    onPressed: () async {
                      final novoAlarme = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaConfigAlarme()),
                      );

                      if (novoAlarme != null && mounted) {
                        setState(() {
                          alarmeList.add(novoAlarme);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: alarmeList.length,
                itemBuilder: (context, index) {
                  return containerAlarme(alarmeList[index], index);
                },
              ),
            ),
            Container(
              color: Color(0xFFEFF9FB),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuRodape(icon: Icons.search, opcao: 'Pesquisar', selecionado: false, onTap: () {},),
                  MenuRodape(icon: Icons.alarm, opcao: 'Alarme', selecionado: true, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaAlarme()),);
                      },),
                  MenuRodape(icon: Icons.person, opcao: 'Perfil', selecionado: false, onTap: () {},),
                  MenuRodape(icon: Icons.home, opcao: 'Menu', selecionado: false, onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaMenu()),);
                    },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}