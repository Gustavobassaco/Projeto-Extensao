import 'package:shop/models/municipio.dart';
// import 'package:shop/utils/constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class MunicipioList {
  final List<Municipio> _municipios = [];

  List<Municipio> get municipios => _municipios;

  // _loadMunicipios() async {
  //   final response = await http.get(
  //     Uri.parse(Constants.populacaoMuniciosUrl),
  //   );
  //   final responseAgua = await http.get(
  //     Uri.parse(Constants.numeroFontesCapitacaoAgua),
  //   );

  //   //if (response.statusCode == 200) {
  //   final json = jsonDecode(response.body);
  //   final jsonAgua = jsonDecode(responseAgua.body);

  //   final base = json[0]['resultados'][0]['series'];
  //   final baseAgua = jsonAgua[0]['resultados'][0]['series'];

  //   int aux = 0;

  //   // for (dynamic objeto in base) {
  //   //   _municipios.add(
  //   //     Municipio(
  //   //       nome: objeto['localidade']['nome'],
  //   //       populacao: objeto['serie']['2021'],
  //   //       codigoMunicipal: objeto['localidade']['id'],
  //   //     ),
  //   //   );
  //   // }

  //   // final apuca = _municipios.firstWhere((element) {
  //   //   return element.nome!.contains('orraz');
  //   // });
  //   // print(apuca.nome);
  //   // print(apuca.populacao);
  //   // print(apuca.codigoMunicipal);
  //   int i = 0;
  //   for (dynamic objeto in base) {
  //     // final cidade = baseAgua.firstWhere((element) {
  //     //   return element['localidade']['id'].contains(objeto['localidade']['id']);
  //     // });
  //     aux++;
  //     if (aux == 10) break;
  //     await http.post(
  //       Uri.parse('${Constants.urlData}/data.json'),
  //       body: jsonEncode({
  //         'nome': objeto['localidade']['nome'],
  //         'populacao': objeto['serie']['2021'],
  //         'codigoMunicipal': objeto['localidade']['id'],
  //         'numeroFontesCapitacaoAgua':
  //             baseAgua[i]['localidade']['id'] == objeto['localidade']['id']
  //                 ? baseAgua[i]['serie']['2017']
  //                 : null,
  //       }),
  //     );
  //     i++;
  //   }

  //   //}
  // }
}
