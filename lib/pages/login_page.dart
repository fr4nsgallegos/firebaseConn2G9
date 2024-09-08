import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconn2g9/constants/constants.dart';
import 'package:firebaseconn2g9/pages/home_page.dart';
import 'package:firebaseconn2g9/widgets/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _correoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Logger logger = Logger();

  Future<void> login(BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: _correoController.text,
        password: _contrasenaController.text,
      )
          .then((value) {
        logger.d(value);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff524175),
                Color(0xffc81d77),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("App de votaciones", style: titulosStyleWhite),
                FlutterLogo(
                  size: 200,
                ),
                Text(
                  "Inicia sesión",
                  style: subtitulosStyleWhite,
                ),
                SizedBox(
                  height: 24,
                ),
                FieldWidget(
                    titulo: "Correo electrónico",
                    controller: _correoController),
                FieldWidget(
                    titulo: "Contraseña", controller: _contrasenaController),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  child: Text("Iniciar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
