import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final user = supabase.auth.currentUser;

  if (user != null) {
    await supabase.from('usuarios').insert({
      'id': user.id,
      'email': user.email,
      'nome': user.email ?? '',
    });
  }

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
  final userId = Supabase.instance.client.auth.currentUser!.id;

  await salvarNovoAlarme(
    nome: nome,
    observacoes: observacoes,
    horario: horarioSelecionado,
    diasDeUso: diasSelecionados,
    ativado: true,
    intervalo: intervaloSelecionado,
    usuarioId: userId,
  );
}
