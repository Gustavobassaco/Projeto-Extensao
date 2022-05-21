import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/best_ranked_cities_page.dart';
import 'package:shop/pages/city_data_page.dart';
import 'package:shop/pages/compare_cities_page.dart';
import 'package:shop/pages/description_page.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/loading_page.dart';
import 'package:shop/repositories/municipio_repository.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MunicipioRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          //fontFamily: 'Anton',
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white60,
            ),
            button: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            caption: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            overline: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
            headline1: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 45,
            ),
            headline2: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.white,
            ),
            headline3: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87,
            ),
            headline4: TextStyle(
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.white,
            ),
            //   headline5: TextStyle(letterSpacing: 0, fontWeight: FontWeight.w700),
            //   headline6:
            //       TextStyle(letterSpacing: 0.7, fontWeight: FontWeight.w400),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.deepPurple,
          ),
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.homePage: (ctx) => const HomePage(),
          AppRoutes.cityDataPage: (ctx) => const CityDataPage(),
          AppRoutes.descriptionPage: (ctx) => const DescriptionPage(),
          AppRoutes.compareCitiesPage: (ctx) => const CompareCitiesPage(),
          AppRoutes.bestRankedCitiesPage: (ctx) => const BestRankedCitiesPage(),
          AppRoutes.loadingPage: (ctx) => const LoadingPage(),
        },
      ),
    );
  }
}
