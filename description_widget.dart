import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/repositories/municipio_repository.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final _dados = Provider.of<MunicipioRepository>(context);
    final infos = _dados.infos0;
    final carregando = _dados.carregando;
    if (carregando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.845),
                      child: ListView.builder(
                        itemCount: infos.keys.toList().length,
                        itemBuilder: (BuildContext context, index) {
                          //index++;
                          return Column(
                            children: [
                              if (index != 0)
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 60,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.orange.shade900,
                                        Colors.deepOrange.shade900,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      infos.keys.toList()[index].toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              if (index != 0)
                                SizedBox(
                                  height: (190 *
                                          infos.values.toList()[index].length)
                                      .toDouble(),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        infos.values.toList()[index].length,
                                    itemBuilder: (BuildContext ctx, i) {
                                      return LayoutBuilder(
                                        builder: (ctx, constraints) {
                                          final proporcao = constraints
                                                  .maxWidth /
                                              MediaQuery.of(context).size.width;
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: 10,
                                                left: 10 * proporcao,
                                                right: 10 * proporcao),
                                            height: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10 * proporcao,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${infos.values.toList()[index][i].keys.toList()[0].toString()} :',
                                                      style: TextStyle(
                                                        fontSize: 10 +
                                                            (6.5 * proporcao),
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height:
                                                              65 * proporcao,
                                                          width:
                                                              250 * proporcao,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .blueAccent)),
                                                            child: Text(
                                                              'Mostrar Detalhes',
                                                              style: TextStyle(
                                                                  fontSize: 10 +
                                                                      (6 *
                                                                          proporcao)),
                                                            ),
                                                            onPressed: () =>
                                                                showDialog<
                                                                    String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  SizedBox(
                                                                height: 600,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      AlertDialog(
                                                                    title: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                            'Sobre o Indicador'),
                                                                        IconButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(context),
                                                                          icon:
                                                                              const Icon(Icons.close),
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    content: Text(infos
                                                                        .values
                                                                        .toList()[
                                                                            index]
                                                                            [i]
                                                                        .values
                                                                        .toList()[
                                                                            0]
                                                                            [2]
                                                                        .toString()),
                                                                    actions: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            TextButton(
                                                                          style:
                                                                              ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                                                                          onPressed: () =>
                                                                              Navigator.pop(context),
                                                                          child:
                                                                              const Text(
                                                                            'Entendi',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
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
                                      );
                                    },
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
