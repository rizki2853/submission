import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/page/Detail/detail.dart';
import 'package:submission1/page/Home/home.dart';
import 'package:submission1/page/Home/search.dart';
import 'package:submission1/page/favorite/favorite.dart';
import 'package:submission1/providers/all_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => RestauranProvider()),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                primaryColor: Colors.amber, primarySwatch: Colors.amber),
            initialRoute: '/home',
            routes: {
              '/home': (context) => HomePage(),
              '/favorite': (context) => const Favorite(),
              '/detail': (context) => DetailPage(
                  id: ModalRoute.of(context)?.settings.arguments.toString()),
              '/search': (context) => SearchPage(
                  query: ModalRoute.of(context)?.settings.arguments.toString()),
            },
          );
        });
  }
}
