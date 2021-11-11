import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/main.dart';
import 'package:firebase_flutter/pessoa.dart';
import 'package:flutter/material.dart';

class ListPessoas extends StatefulWidget {
  const ListPessoas({Key? key}) : super(key: key);

  @override
  _ListPessoasState createState() => _ListPessoasState();
}

final listPessoas = FirebaseDatabase.instance.reference().child('pessoas');

class _ListPessoasState extends State<ListPessoas> {
  List<Map<dynamic, dynamic>> pessoas = [];
  List<dynamic> chaves = [];
  TextEditingController txtNomeNovo = TextEditingController();
  TextEditingController txtIdadeNova = TextEditingController();
  TextEditingController txtEnderecoNovo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Pessoas List'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
              stream: pessoasReference.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  pessoas.clear();
                  DataSnapshot dataValues = snapshot.data!.snapshot;
                  Map<dynamic, dynamic> values = dataValues.value;

                  if (values != null) {
                    values.forEach((key, value) {
                      pessoas.add(value);
                      if (!chaves.contains(key)) {
                        chaves.add(key);
                      }
                      //print(value);
                      //print(key);
                    });

                    return Expanded(
                      child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: pessoas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(8.0),
                                      title: Text(pessoas[index]['nome']),
                                      subtitle: Text(pessoas[index]['idade']),
                                      onTap: () {
                                        AlertDialog(
                                          title: Text('Atualizar dados'),
                                          content: Expanded(
                                            child: Column(children: [
                                              TextField(
                                                controller: txtNomeNovo,
                                              ),
                                              TextField(
                                                controller: txtIdadeNova,
                                              ),
                                              TextField(
                                                controller: txtEnderecoNovo,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    listPessoas
                                                        .child(chaves[index])
                                                        .set(Pessoa(
                                                            nome: txtNomeNovo
                                                                .text,
                                                            idade: txtIdadeNova
                                                                .text));
                                                  },
                                                  child: Text('Salvar'))
                                            ]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      listPessoas.child(chaves[index]).remove();
                                    },
                                  ))
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                        child: Text("Sem dados para serem exibidos",
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center));
                  }
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
