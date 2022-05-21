import 'package:flutter/material.dart';
import 'package:shop/components/background_widget.dart';
import 'package:shop/components/description_widget.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Descrição dos Indicadores',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Stack(
        children: const [
          BackgroundWidget(),
          DescriptionWidget(),
        ],
      ),
    );
  }
}
