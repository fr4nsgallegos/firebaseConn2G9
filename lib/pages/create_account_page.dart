import 'package:firebaseconn2g9/constants/constants.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  TextEditingController _correoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();

  Widget buildField(String titulo, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: cabeceraFieldStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        )
      ],
    );
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
                buildField("Correo electrónico", _correoController),
                buildField("Contraseña", _contrasenaController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
