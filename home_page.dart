import 'package:flutter/material.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/background_widget.dart';
import 'package:shop/repositories/municipio_repository.dart';
import 'package:shop/utils/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MunicipioRepository municipioRepository = MunicipioRepository();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cidades Sustentáveis',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          const BackgroundWidget(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Seja bem Vindo!',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Este é um app criado com um fim de acessar informações dos municípios do Brasil, seguindo os indicadores ABNT para cidades Sustentáveis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 40,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      elevation: 5,
                      primary: Colors.indigo.shade800,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.cityDataPage);
                    },
                    child: const Text(
                      'Pesquisar Cidade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      elevation: 5,
                      primary: Colors.indigo.shade800,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.compareCitiesPage);
                    },
                    child: const Text(
                      'Comparar Cidades',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      elevation: 5,
                      primary: Colors.indigo.shade800,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.descriptionPage);
                    },
                    child: const Text(
                      'Descrição dos Indicadores',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
