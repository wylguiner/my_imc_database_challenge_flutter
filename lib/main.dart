import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_imc_database_challenge_flutter/models/pessoa_model.dart';
import 'package:my_imc_database_challenge_flutter/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider
      .getApplicationDocumentsDirectory(); // pega o caminho de documentos do dispositivo do usuário para que o banco de dados seja salva
  Hive.init(documentsDirectory
      .path); // inicia o banco de dados no caminho designado anteriormente
  Hive.registerAdapter(
      PessoaAdapter()); // registra o model depois de usar o código dos pacotes BUILD_RUNNER e HIVE_GENERATOR
  runApp(const MyApp());
}
