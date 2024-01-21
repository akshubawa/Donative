import 'package:donative/app/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCUqFdSvViqXx4N2QRPz-NnTxAOAf6Rw5Q",
        appId: '1:762726674958:android:1125fe9997da7d477d825f',
        projectId: 'donative-e0a5e',
        messagingSenderId: '762726674958'),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(auth: FirebaseAuth.instance));
}
