import 'package:flutter/material.dart';
import 'package:my_imc_database_challenge_flutter/models/pessoa_model.dart';
import 'package:my_imc_database_challenge_flutter/repositories/pessoa_repository.dart';
import 'package:my_imc_database_challenge_flutter/services/calculadora_imc_service.dart';
import 'package:my_imc_database_challenge_flutter/shared/widgets/text_label.dart';

class CalculoIMCPage extends StatefulWidget {
  const CalculoIMCPage({super.key});

  @override
  State<CalculoIMCPage> createState() => _CalculoIMCPageState();
}

class _CalculoIMCPageState extends State<CalculoIMCPage> {
  late PessoaRepository pessoaRepository;
  var _pessoas = <Pessoa>[];

  var nomeController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var pesoController = TextEditingController(text: "");

  var calculadora = Calculo();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    obterPessoas();
  }

  void obterPessoas() async {
    pessoaRepository = await PessoaRepository.carregar();
    _pessoas = pessoaRepository.obterDados();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Cálculo de IMC!")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(child: TextLabel(texto: "Nome")),
              TextField(
                  controller: nomeController, keyboardType: TextInputType.name),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TextLabel(texto: "Altura"),
                      TextField(
                          controller: alturaController,
                          keyboardType: TextInputType.number),
                    ],
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                    children: [
                      const TextLabel(texto: "Peso"),
                      TextField(
                          controller: pesoController,
                          keyboardType: TextInputType.number),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextButton(
                        onPressed: () async {
                          double altura = double.parse(alturaController.text);
                          double peso = double.parse(pesoController.text);
                          var imc = double.parse(
                              calculadora.calcularIMC(peso, altura));
                          var resultado = calculadora.resultadoIMC(imc);

                          await pessoaRepository.salvar(Pessoa(
                              nomeController.text,
                              altura,
                              peso,
                              imc,
                              resultado));
                          nomeController.text = "";
                          pesoController.text = "";
                          alturaController.text = "";
                          FocusScope.of(context).unfocus();
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                          obterPessoas();
                          setState(() {});
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 69, 94, 207)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextLabel(texto: "Calcular"),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextButton(
                        onPressed: () async {
                          await pessoaRepository.limparDados();
                          obterPessoas();
                          setState(() {});
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 69, 94, 207)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextLabel(texto: "Limpar"),
                        )),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                controller: scrollController,
                itemCount: _pessoas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var pessoa = _pessoas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await pessoaRepository.excluir(pessoa);
                      obterPessoas();
                    },
                    key: Key(pessoa.id),
                    child: ListTile(
                        title: TextLabel(texto: "Olá ${pessoa.nome}"),
                        subtitle: TextLabel(
                            texto:
                                "Seu IMC é de ${pessoa.imc} e seu resultado é: ${pessoa.resultado}")),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
