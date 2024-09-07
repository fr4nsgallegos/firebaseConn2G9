import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g9/pages/list_future_page.dart';
import 'package:firebaseconn2g9/pages/stream_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  usersReference.get().then((value) {
                    value.docs.forEach((e) {
                      print(e.data());
                    });
                  });
                },
                child: Text("Get data"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference
                      .where("name", isEqualTo: "Jhonny")
                      .where("age", isGreaterThan: 39)
                      .get()
                      .then(
                    (value) {
                      QuerySnapshot userCollection = value;
                      List<QueryDocumentSnapshot> docs = userCollection.docs;
                      docs.forEach((element) {
                        print("--------------------------");
                        print(element.id);
                        print(element.data());
                        print("--------------------------");
                      });
                    },
                  );
                },
                child: Text("Data filtrada"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.add({
                    "name": "Andrea",
                    "lastName": "VMengoza",
                    "age": "36",
                    "estatura": 169,
                  }).then((value) {
                    print(value);
                    print(value.id);
                  });
                },
                child: Text("Agrear user"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").set({
                    "name": "Javier",
                    "lastName": "Madera",
                    "age": 65,
                    "estatura": 168
                  });
                },
                child: Text("Inserción 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").update({
                    "name": "Anastacio",
                    "nacionality": "Peruano",
                  });
                },
                child: Text("Actualización"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").delete();
                },
                child: Text("Eliminar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ListFuturePage(),
                    ),
                  );
                },
                child: Text("List Future Page"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => StreamPage(),
                    ),
                  );
                },
                child: Text("Stream Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
