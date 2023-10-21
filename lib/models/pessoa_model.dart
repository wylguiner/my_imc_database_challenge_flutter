import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'pessoa_model.g.dart';

@HiveType(typeId: 1)
class Pessoa extends HiveObject {
  @HiveField(0)
  final String _id = UniqueKey().toString();

  @HiveField(1)
  String _nome = "";

  @HiveField(2)
  double _altura = 0;

  @HiveField(3)
  double _peso = 0;

  @HiveField(4)
  double _imc = 0;

  @HiveField(5)
  String _resultado = "";

  Pessoa(this._nome, this._altura, this._peso, this._imc, this._resultado);

  String get id => _id;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get imc => _imc;

  set imc(double imc) {
    _imc = imc;
  }

  String get resultado => _resultado;

  set resultado(String resultado) {
    _resultado = resultado;
  }
}
