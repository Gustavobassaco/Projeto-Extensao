/*
import 'package:flutter/material.dart';
import 'package:testes/data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final dados = Data().dados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Testes App'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(50, 0, 150, 0.9),
                  Color.fromRGBO(50, 0, 220, 1),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      64,
                  child: ListView.builder(
                    itemCount: dados.keys.toList().length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                       
                            
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              dados.keys.toList()[index].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: (80 * dados.values.toList()[index].length)
                                .toDouble(),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dados.values.toList()[index].length,
                              itemBuilder: (BuildContext ctx, i) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 80,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.purple.shade600,
                                          Colors.purple.shade900,
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${dados.values.toList()[index][i].keys.toList()[0].toString()} :',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                ' ${dados.values.toList()[index][i].values.toList()[0][0].toString()}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Sobre o Indicador'),
                                                    content: Text(dados.values
                                                        .toList()[index][i]
                                                        .values
                                                        .toList()[0][1]
                                                        .toString()),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .blue)),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                          'Entendi',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.lightBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text('skjdfksjdfhsdf'),
                // Text(dados.length.toString()), //3
                // Divider(),
                // Text(dados.keys.toString()), // (Economia, Educação, Turismo)
                // Divider(),
                // Text(dados.keys.toList()[1].toString()), // Educação
                // Divider(),
                // //Produto Interno Bruto
                // Text(dados.values.toList()[0][0].keys.toList()[0].toString()),
                // Divider(),
                // // Valor do PIB
                // Text(dados.values.toList()[0][0].values.toList()[0][0].toString()),
                // Divider(),
                // // Explicação do pib
                // Text(dados.values.toList()[0][0].values.toList()[0][1].toString()),
                // Divider(),
                // //Text(dados.values.toList()[0].toString()),
                //Text(dados.values.toList()[0].toString())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/