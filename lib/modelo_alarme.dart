import 'package:flutter/material.dart';

class Alarme {
  final String nome;
  final TimeOfDay horario;
  final String intervalo;
  final String diasDeUso;
  final String observacoes;
  bool ativado;

  Alarme({
    required this.nome,
    required this.horario,
    required this.intervalo,
    required this.diasDeUso,
    required this.observacoes,
    this.ativado = true,
  });
}