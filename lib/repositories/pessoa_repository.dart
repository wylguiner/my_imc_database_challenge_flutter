import 'package:hive/hive.dart';
import 'package:my_imc_database_challenge_flutter/models/pessoa_model.dart';

class PessoaRepository {
  static late Box _box;

  PessoaRepository._criar();

  static Future<PessoaRepository> carregar() async {
    if (Hive.isBoxOpen('pessoaModel')) {
      _box = Hive.box('pessoaModel');
    } else {
      _box = await Hive.openBox('pessoaModel');
    }
    return PessoaRepository._criar();
  }

  salvar(Pessoa pessoa) {
    _box.add(pessoa);
  }

  excluir(Pessoa pessoa) {
    pessoa.delete();
  }

  List<Pessoa> obterDados() {
    return _box.values.cast<Pessoa>().toList();
  }

  Future<void> limparDados() async {
    await _box.clear(); // Limpa todos os dados no Hive Box
  }
}
