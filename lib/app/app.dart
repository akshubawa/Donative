import 'package:donative/app/splash_screen/splash_screen.dart';
import 'package:donative/themes/themes.dart';
import 'package:donative/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donative',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MyThemes.lightColorScheme,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: MyThemes.darkColorScheme,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      home: const SplashScreen(
        child: LoginView(),
      ),
    );
  }
}
