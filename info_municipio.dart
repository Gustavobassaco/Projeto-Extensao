import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/repositories/municipio_repository.dart';

class InfoMunicipio extends StatefulWidget {
  const InfoMunicipio({Key? key, this.numero = 0}) : super(key: key);
  final int numero;

  @override
  _InfoMunicipioState createState() => _InfoMunicipioState();
}

class _InfoMunicipioState extends State<InfoMunicipio> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  List<List<String>> index_list = [];
  bool _isOpenField = false;
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final _dados = Provider.of<MunicipioRepository>(context);
    final municipios = _dados.municipios;
    final data = _dados.data;
    final infos = widget.numero == 0 ? _dados.infos0 : _dados.infos1;

    //final municipios = MunicipioRepository().municipios;
    //final data = MunicipioRepository().data;

    _onChanged(String nome) {
      setState(() {
        _isSelected = false;
        int cont = 0;
        index_list = [];
        for (int i = 0; i < municipios.length; i++) {
          if (municipios[i]
              .toString()
              .toLowerCase()
              .contains(nome.toLowerCase())) {
            index_list.add(municipios[i]);
            cont++;
          }
          if (cont == 15) {
            break;
          }
        }

        if (nome.isNotEmpty) {
          _isOpenField = true;
        } else {
          _isOpenField = false;
        }
      });
    }

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
              SizedBox(height: _isSelected ? 0 : 20),
              if (_isSelected == false)
                Text(
                  'Para Obter as Informações desejadas, digite o nome do Municipio abaixo:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.indigo.shade900,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  controller: myController,
                  onChanged: (text) => _onChanged(text),
                  decoration: const InputDecoration(
                      //suffix: Icon(Icons.location_city),
                      hintText: 'Nome do Municipio',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                      border: InputBorder.none //OutlineInputBorder(),
                      ),
                ),
              ),
              if (_isOpenField)
                SizedBox(
                  width: 400,
                  height: MediaQuery.of(context).size.height * 0.63,
                  child: ListView.builder(
                    itemCount: index_list.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.indigo.shade900,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 60,
                        child: ListTile(
                          title: Text(
                            index_list[index][0],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          onTap: () {
                            myController.text = index_list[index][0];
                            setState(() {
                              for (int i = 0; i < data.length; i++) {
                                if (data[i]['data']['nome'] ==
                                    myController.text) {
                                  widget.numero == 0
                                      ? _dados.setIndex0(i)
                                      : _dados.setIndex1(i);
                                  break;
                                }
                              }
                              _isOpenField = false;
                              _isSelected = true;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              if (_isSelected)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.76,
                        child: ListView.builder(
                          itemCount: infos.keys.toList().length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 80,
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
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
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
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${infos.values.toList()[index][i].keys.toList()[0].toString()} :',
                                                      style: TextStyle(
                                                        fontSize: 10 +
                                                            (6 * proporcao),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          ' ${infos.values.toList()[index][i].values.toList()[0][0].toString()}',
                                                          style: TextStyle(
                                                            fontSize: 10 +
                                                                (6 * proporcao),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          iconSize: 18 +
                                                              (6 * proporcao),
                                                          onPressed: () =>
                                                              showDialog<
                                                                  String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'Sobre o Indicador'),
                                                              content: Text(infos
                                                                  .values
                                                                  .toList()[
                                                                      index][i]
                                                                  .values
                                                                  .toList()[0]
                                                                      [1]
                                                                  .toString()),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              Colors.blue)),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                    'Entendi',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          icon: const Icon(
                                                            Icons.info_outline,
                                                            color: Colors
                                                                .lightBlue,
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

/*
class MunicipioDetailWidget extends StatelessWidget {
  const MunicipioDetailWidget({
    Key? key,
    required this.data,
    required int indexSelected,
  })  : _dados = indexSelected,
        super(key: key);

  final List data;
  final int _dados;

  @override
  Widget build(BuildContext context) {
    int popInformal =
        (int.parse(data[_dados]['data']['popInformal'][0]) +
            int.parse(data[_dados]['data']['popInformal'][1]));

    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${data[_dados]['data']['nome']}',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10),
          Text(
            'Sigla: ${data[_dados]['id']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 30),
          Text(
            'População: ${data[_dados]['data']['populacao']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Divider(),
          Text(
            'Area (Km^2): ${data[_dados]['data']['areaMunicipio']['area']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Divider(),
          Text(
            'Densidade demográfica (hab/km^2): ${data[_dados]['data']['areaMunicipio']['densidade']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Topico(topico: 'Economia'),
          Text(
            'Produto Interno Bruto:\n2015 - ${data[_dados]['data']['pib']['2015']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '2016 - ${data[_dados]['data']['pib']['2016']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '2017 - ${data[_dados]['data']['pib']['2017']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '2018 - ${data[_dados]['data']['pib']['2018']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '2019 - ${data[_dados]['data']['pib']['2019']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Text(
            'População Economicamente Ativa: ${data[_dados]['data']['popEconAtiva']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Text(
            'População Empregada: ${data[_dados]['data']['popEmpregada']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Text(
            'População informal: ${popInformal.toString()}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Text(
            'Percentual Populção Empregada: ${(100 * int.parse(data[_dados]['data']['popEmpregada']) / int.parse(data[_dados]['data']['popEconAtiva'])).toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(),
          Text(
            'Porcentagem da força de trabalho em empregos informais: ${(100 * popInformal / int.parse(data[_dados]['data']['popEconAtiva'])).toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Topico(topico: 'Educação'),
          const Topico(topico: 'Energia'),
          const Topico(topico: 'Meio Ambiente'),
          const Topico(topico: 'Finanças'),
          const Topico(topico: 'Governança'),
          const Topico(topico: 'Saúde'),
          const Topico(topico: 'Habitação'),
          const Topico(topico: 'População e Condições sociais'),
          const Topico(topico: 'Segurança'),
          const Topico(topico: 'Resíduos Sólidos'),
          const Topico(topico: 'Telecomunicações'),
          const Topico(topico: 'Transporte'),
          const Topico(topico: 'Segurança Alimentar'),
          const Topico(topico: 'Resíduos Sólidos'),
          const Topico(topico: 'Planejamento Urbano'),
          const Topico(topico: 'Água'),
          Text(
            'Numero de fontes de capitação de água: ${data[_dados]['data']['numeroFontesCapitacaoAgua']}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class Topico extends StatelessWidget {
  const Topico({Key? key, required this.topico}) : super(key: key);
  final String topico;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 10),
      padding: const EdgeInsets.only(bottom: 2, left: 5, right: 5),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepOrange,
      ),
      child: Center(
        child: Text(
          topico,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
*/

