import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/background_widget.dart';
import 'package:shop/repositories/municipio_repository.dart';

class BestRankedCitiesPage extends StatefulWidget {
  const BestRankedCitiesPage({Key? key}) : super(key: key);

  @override
  State<BestRankedCitiesPage> createState() => _BestRankedCitiesPageState();
}

class _BestRankedCitiesPageState extends State<BestRankedCitiesPage> {
  @override
  Widget build(BuildContext context) {
    final municipios = Provider.of<MunicipioRepository>(context).municipios;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cidades Mais bem Rankeadas'),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          ListView.builder(
              itemCount: municipios.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(municipios[index][0].toString()),
                      Text(municipios[index][1].toString()),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
