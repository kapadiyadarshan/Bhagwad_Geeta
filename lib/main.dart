import 'package:bhagwad_geeta/controller/lang_controller.dart';
import 'package:bhagwad_geeta/utils/route_utils.dart';
import 'package:bhagwad_geeta/views/screens/chapter_page.dart';
import 'package:bhagwad_geeta/views/screens/detail_page.dart';
import 'package:bhagwad_geeta/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoute.homePage,
      routes: {
        MyRoute.homePage: (context) => const HomePage(),
        MyRoute.chapterPage: (context) => const ChapterPage(),
        MyRoute.detailPage: (context) => const DetailPage(),
      },
    );
  }
}
