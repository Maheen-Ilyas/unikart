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
          seedColor: const Color.fromARGB(255, 35, 157, 159),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 80,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          overlayColor: const MaterialStatePropertyAll(
            Color.fromARGB(128, 81, 154, 147),
          ),
          indicatorShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          labelTextStyle: MaterialStatePropertyAll(
            GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const MaterialStatePropertyAll(
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
