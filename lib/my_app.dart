import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hacker_news_bloc.dart';
import 'my_home_page.dart';

const _primaryColor = Colors.white;

class MyApp extends StatelessWidget {
  const MyApp(this._hackerNewsBloc, {Key? key}) : super(key: key);

  final HackerNewsBloc _hackerNewsBloc;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _primaryColor,
        primaryColor: _primaryColor,
        canvasColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: _primaryColor,
          unselectedItemColor: Colors.white54,
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontFamily: GoogleFonts.ebGaramond().fontFamily,
            fontSize: 10,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(_hackerNewsBloc),
    );
  }
}
