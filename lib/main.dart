import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "pages/CovidDetails.dart";
import "pages/CurrentOutbreak.dart";

void main() {
  runApp(CovidApp());
}

class CovidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid App",
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Color.fromRGBO(32, 42, 68, 1)),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color.fromRGBO(32, 42, 68, 1),
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(color: Color.fromRGBO(32, 42, 68, 1)),
        ),
        primaryColor: Color.fromRGBO(33, 43, 71, 1),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/CurrentOutbreak": (context) => CurrentOutbreak(),
        "/CovidDetails": (context) => CovidDetails(),
      },
      initialRoute: "/CurrentOutbreak",
    );
  }
}
