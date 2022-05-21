import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Cidades Sustentáveis',
              style: Theme.of(context).textTheme.headline2,
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text(
              'Pesquisar Cidade',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.cityDataPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.compare),
            title: Text(
              'Comparar Cidades',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.compareCitiesPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(
              'Descrição dos Indicadores',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.descriptionPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              'Cidades mais Sustentáveis',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.bestRankedCitiesPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.business),
            title: Text(
              'Cidades mais Resilientes',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.bestRankedCitiesPage);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              'Sair',
              style: Theme.of(context).textTheme.headline3,
            ),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
