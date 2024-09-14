import 'package:firebaseconn2g9/pages/create_account_page.dart';
import 'package:firebaseconn2g9/pages/home_page.dart';
import 'package:firebaseconn2g9/pages/map_page.dart';
import 'package:firebaseconn2g9/pages/map_page_2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: MapPage2(),
    ),
  );
}
