import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/list_pessoas.dart';
import 'package:firebase_flutter/pessoa.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final pessoasReference = FirebaseDatabase.instance.reference().child('pessoas');

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtEndereco = TextEditingController();

  void addPessoa(Pessoa p) {
    setState(() {
      pessoasReference.push().set({'nome': p.nome, 'idade': p.idade});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.amber, style: BorderStyle.solid)),
                      hintText: 'Nome'),
                  controller: txtNome,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.amber, style: BorderStyle.solid)),
                      hintText: 'Idade'),
                  controller: txtIdade,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.amber, style: BorderStyle.solid)),
                      hintText: 'Endereço'),
                  controller: txtEndereco,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListPessoas()))
                      },
                  child: Text('Read data'))
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Pessoa p = Pessoa(
              nome: txtNome.text,
              idade: txtIdade.text,
              endereco: txtEndereco.text);
          //this.handler.insert(p);
          //this.handler.listarPessoas();
          addPessoa(p); //storage no Firebase
        },
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
