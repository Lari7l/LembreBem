import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lembrebem/modelo_alarme.dart' as modelo;

class Alarme {
  String? id;
  String nome;
  String observacoes;
  TimeOfDay horario;
  String diasDeUso;
  bool ativado;
  String intervalo;

  Alarme({
    this.id,
    required this.nome,
    required this.observacoes,
    required this.horario,
    required this.diasDeUso,
    required this.ativado,
    required this.intervalo,
  });

  factory Alarme.fromJson(Map<String, dynamic> json) {
    final horaStr = json['hora_alarme'] ?? '00:00:00';
    final partes = horaStr.split(':');
    final hora = TimeOfDay(
      hour: int.parse(partes[0]),
      minute: int.parse(partes[1]),
    );
    return Alarme(
      id: json['id']?.toString() ?? '',
      nome: json['titulo'] ?? '',
      observacoes: json['descricao'] ?? '',
      horario: hora,
      diasDeUso: json['dias_uso'] ?? '',
      ativado: json['ativo'] ?? false,
      intervalo: json['intervalo'] ?? '',
    );
  }
}

Future<void> salvarNovoAlarme({
  required String nome,
  required String observacoes,
  required TimeOfDay horario,
  required String diasDeUso,
  required bool ativado,
  required String intervalo,
  required String usuarioId,
}) async {
  final supabase = Supabase.instance.client;

  final dataHoje = DateTime.now();
  final dataAlarme =
      "${dataHoje.year.toString().padLeft(4, '0')}-${dataHoje.month.toString().padLeft(2, '0')}-${dataHoje.day.toString().padLeft(2, '0')}";
  final horaAlarme =
      "${horario.hour.toString().padLeft(2, '0')}:${horario.minute.toString().padLeft(2, '0')}:00";

  final novoAlarme = {
    'usuario_id': usuarioId,
    'titulo': nome,
    'descricao': observacoes,
    'data_alarme': dataAlarme,
    'hora_alarme': horaAlarme,
    'repetir': false,
    'ativo': ativado,
    'created_at': DateTime.now().toIso8601String(),
  };

  final response = await supabase.from('alarmes').insert(novoAlarme).select();

  print('Tentando salvar alarme: $novoAlarme');
  print('Resposta do Supabase: $response');

  if (response == null || (response is Map && response['error'] != null)) {
    throw Exception('Erro ao salvar alarme: $response');
  }
}

Future<void> criarAlarmeExemplo() async {
  String nome = 'Alarme Teste';
  String observacoes = 'Não esquecer de testar!';
  TimeOfDay horarioSelecionado = TimeOfDay.now();
  String diasSelecionados = 'Segunda, Quarta, Sexta';
  String intervaloSelecionado = '10';
  final userId = Supabase.instance.client.auth.currentUser?.id;

  await verificarEInserirUsuario();

  await salvarNovoAlarme(
    nome: nome,
    observacoes: observacoes,
    horario: horarioSelecionado,
    diasDeUso: diasSelecionados,
    ativado: true,
    intervalo: intervaloSelecionado,
    usuarioId: userId!,
  );
}

Future<void> verificarEInserirUsuario() async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user != null) {
    final existe =
        await supabase
            .from('usuarios')
            .select()
            .eq('id', user.id)
            .maybeSingle();

    print('Usuário existe na tabela usuarios? $existe');

    if (existe == null) {
      final response =
          await supabase.from('usuarios').insert({
            'id': user.id,
            'email': user.email,
            'nome': user.email ?? '',
            'cpf': '00000000000',
            'data_nascimento': null,
          }).select();

      print('Tentativa de inserir usuário: $response');

      bool usuarioCriado = false;
      int tentativas = 0;
      while (!usuarioCriado && tentativas < 5) {
        await Future.delayed(Duration(milliseconds: 300));
        final existeAgora =
            await supabase
                .from('usuarios')
                .select()
                .eq('id', user.id)
                .maybeSingle();
        print('Tentativa $tentativas - Usuário existe agora? $existeAgora');
        if (existeAgora != null) usuarioCriado = true;
        tentativas++;
      }
      if (!usuarioCriado) {
        throw Exception('Usuário não foi criado na tabela usuarios!');
      }
    }
  }
}

Future<void> atualizarAlarme({
  required String id,
  required String nome,
  required String observacoes,
  required TimeOfDay horario,
  required bool ativado,
}) async {
  final supabase = Supabase.instance.client;
  final horaAlarme =
      "${horario.hour.toString().padLeft(2, '0')}:${horario.minute.toString().padLeft(2, '0')}:00";

  final dadosAtualizados = {
    'titulo': nome,
    'descricao': observacoes,
    'hora_alarme': horaAlarme,
    'ativo': ativado,
  };

  final response =
      await supabase
          .from('alarmes')
          .update(dadosAtualizados)
          .eq('id', id)
          .select();

  print('Atualizando alarme: $dadosAtualizados');
  print('Resposta do Supabase: $response');

  if (response == null || (response is Map && response['error'] != null)) {
    throw Exception('Erro ao atualizar alarme: $response');
  }
}

class AlarmesPage extends StatefulWidget {
  @override
  _AlarmesPageState createState() => _AlarmesPageState();
}

class _AlarmesPageState extends State<AlarmesPage> {
  String _selectedUso = 'Segunda'; // valor inicial
  final List<String> _diasUsoList = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo',
  ];

  @override
  void initState() {
    super.initState();
    // if (widget.alarme != null) {
    //   _selectedUso = widget.alarme!.diasDeUso;
    //   // ...outros campos...
    // } else {
    //   _selectedUso = _diasUsoList.first;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alarmes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Selecione o dia de uso:'),
            DropdownButton<String>(
              value:
                  _diasUsoList.contains(_selectedUso)
                      ? _selectedUso
                      : _diasUsoList.first,
              items:
                  _diasUsoList.map((dia) {
                    return DropdownMenuItem<String>(
                      value: dia,
                      child: Text(dia),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUso = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> atualizarAlarmeExemplo(Alarme alarmeEditado) async {
  await atualizarAlarme(
    id: alarmeEditado.id!,
    nome: alarmeEditado.nome,
    observacoes: alarmeEditado.observacoes,
    horario: alarmeEditado.horario,
    ativado: alarmeEditado.ativado,
  );
}
