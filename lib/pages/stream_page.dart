import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  StreamController<int> myStreamController = StreamController();
  Future<int> getNumber() async {
    return 10;
  }

  Stream<int> counter() async* {
    for (int i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getNumber().then((value) {
    //   print(value);
    // });
    print("init Stream");
    Stream<int> myStream = Stream.fromFuture(getNumber());
    print("STREAM CREADO");
    myStream.listen((event) {
      print(event);
    });
    // counter().listen((value) {
    //   print(value);
    // }).onDone(() {
    //   print("FINALIZADO");
    // });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stream Page"),
        ),
        //STREAM BUILDER
        // body: StreamBuilder(
        //   stream: frutasStream(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       return Center(
        //         child: Text(
        //           snapshot.data.toString(),
        //           style: TextStyle(fontSize: 40),
        //         ),
        //       );
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),

        // //FUTURE BUILDER
        // body: FutureBuilder(
        //   future: getNumber(),
        //   builder: (BuildContext context, AsyncSnapshot snap) {
        //     if (snap.hasData) {
        //       return Center(
        //         child: Text(
        //           snap.data.toString(),
        //           style: TextStyle(fontSize: 40),
        //         ),
        //       );
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
