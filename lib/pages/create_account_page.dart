import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconn2g9/constants/constants.dart';
import 'package:firebaseconn2g9/pages/home_page.dart';
import 'package:firebaseconn2g9/pages/login_page.dart';
import 'package:firebaseconn2g9/widgets/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class CreateAccountPage extends StatelessWidget {
  TextEditingController _correoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  var logger = Logger(
      // printer: PrettyPrinter(),
      );

  Future<void> createAccount(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _correoController.text,
              password: _contrasenaController.text);
      logger.d(userCredential);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            // error.toString(),
            mapErrorAuth(
              error.toString(),
            ),
          ),
        ),
      );
    }
  }

  String mapErrorAuth(String errorMessage) {
    if (errorMessage.contains("email-already-in-use")) {
      return "La dirección de correo ya esta en uso";
    } else if (errorMessage.contains("invalid-email")) {
      return "El correo no es válido";
    } else if (errorMessage.contains("weak-password")) {
      return "La contraseña no cumple con los estándares";
    } else {
      return "Ocurrió un problema al registrar la cuenta";
    }
  }

  Future<User?> signInWithGoogle() async {
    //SOLICITAR EL INICIO DE SESIÓN CON GOOGLE
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    //OBTENER LA AUTENTICACIÓN DE GOOGLE
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    //CREAR LAS CREDENCIALES PARA INICIO EN FIREBASE
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    //INICIAR SESIÓN EN FIREBASE CON LAS CREDENCIALES DE GOOGLE
    User? user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    //DEBUG IMPRESIÓN
    print(user?.displayName);
    return user;
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
                  "Crear cuenta",
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "o Inicia sesión",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    createAccount(context);
                  },
                  child: Text("Crear cuenta"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "o Inicia sesión con",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        signInWithGoogle().then((value) {
                          if (value != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        });
                      },
                      icon: Icon(
                        Icons.g_mobiledata,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
