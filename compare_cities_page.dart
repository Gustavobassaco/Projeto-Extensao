import 'package:flutter/material.dart';
import 'package:shop/components/background_widget.dart';
import 'package:shop/components/info_municipio.dart';

class CompareCitiesPage extends StatelessWidget {
  const CompareCitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Comparar Cidades'),
      ),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: const InfoMunicipio(numero: 0),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.018,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: const InfoMunicipio(numero: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
