import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListFuturePage extends StatelessWidget {
  CollectionReference usersReferece =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Future Page"),
      ),
      body: FutureBuilder(
        future: usersReferece.get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("-------------------------");
          print("snapshot: $snapshot");
          print("conectionstate: ${snapshot.connectionState}");
          print("has error: ${snapshot.hasError}");
          print("has data: ${snapshot.hasData}");
          print("data: ${snapshot.data}");
          print("-------------------------");

          if (snapshot.hasData) {
            QuerySnapshot userCollection = snapshot.data;
            List<QueryDocumentSnapshot> docs = userCollection.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    docs[index]["name"],
                  ),
                  subtitle: Text("Edad: ${docs[index]["age"]}"),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
