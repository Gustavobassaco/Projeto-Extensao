import 'package:flutter/material.dart';
import 'package:shop/components/background_widget.dart';
import 'package:shop/components/info_municipio.dart';

class CityDataPage extends StatefulWidget {
  const CityDataPage({Key? key}) : super(key: key);

  @override
  State<CityDataPage> createState() => _CityDataPageState();
}

class _CityDataPageState extends State<CityDataPage> {
  //late List<Municipio> municipios;
  //late MunicipioRepository repositorio_municipios;

  @override
  Widget build(BuildContext context) {
    //MunicipioList municipios = MunicipioList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesquisar Cidade',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Stack(
        children: const [
          BackgroundWidget(),
          InfoMunicipio(),
        ],
      ),
    );
  }
}
