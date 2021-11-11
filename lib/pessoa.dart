class Pessoa {
  final int?
      id; //'?'-> usada para cheacage de valor nulo, não precisando do required no construtor
  final String nome;
  final String idade;
  final String? endereco;

  Pessoa({this.id, required this.nome, required this.idade, this.endereco});

  Map<String, Object?> toMap() {
    return {'id': id, 'nome': nome, 'idade': idade, 'endereco': endereco};
  }

  @override
  String toString() {
    return 'Pessoa{id: $id, nome: $nome, idade: $idade, endereco: $endereco}';
  }
}
