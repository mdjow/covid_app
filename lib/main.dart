import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart" show GoogleFonts;

import "pages/covid_details_page.dart" show CovidDetailsPage;
import "pages/current_outbreak_page.dart" show CurrentOutbreakPage;

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
        "/current_outbreak_page": (context) => CurrentOutbreakPage(),
        "/covid_details_page": (context) => CovidDetailsPage(),
      },
      initialRoute: "/current_outbreak_page",
    );
  }
}
