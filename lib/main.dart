import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.outfit().toString(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF80BCBD),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          height: 80,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          overlayColor: MaterialStatePropertyAll(
            Color.fromARGB(128, 81, 154, 147),
          ),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: MaterialStatePropertyAll(
            IconThemeData(
              size: 26,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const NavBar(),
    );
  }
}
