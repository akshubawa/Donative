import 'package:donative/app/splash_screen/splash_screen.dart';
import 'package:donative/themes/themes.dart';
import 'package:donative/views/profile_page.dart';
import 'package:donative/views/screen.dart';
import 'package:donative/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final FirebaseAuth auth;
  const MyApp({required this.auth, super.key});

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
      home: SplashScreen(
        child: AuthChecker(auth: auth),
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  final FirebaseAuth auth;

  const AuthChecker({required this.auth, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const Screen();
        } else {
          return const SignupView();
        }
      },
    );
  }
}
