import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late StreamController<int> streamController;

  Future<int> getNumber() async {
    return 10;
  }

  Stream<String> frutasStream() async* {
    List<String> namesFrutas = ["pera", "manzana", "durazno", "melocoton"];
    for (int i = 0; i < namesFrutas.length; i++) {
      yield namesFrutas[i];
      await Future.delayed(Duration(seconds: 2));
    }
  }

  void _startController() {
    Stream<int> counter() async* {
      for (int i = 0; i < 10; i++) {
        yield i;
        await Future.delayed(Duration(seconds: 2));
      }
    }

    counter().listen(
      (event) {
        print(event);
        streamController.sink
            .add(event); //ENVIO LOS EVENTOS AL STREAM CONTROLLER
      },
      onError: (error) {
        if (!streamController.isClosed) {
          streamController.sink.addError(error);
        }
      },
      onDone: () {
        if (!streamController.isClosed) {
          streamController.close();
        }
      },
    );
  }

  @override
  void initState() {
    streamController = StreamController<int>();
    _startController();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getNumber().then((value) {
      print(value);
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stream Page"),
        ),
        //STREAM BUILDER
        body: StreamBuilder(
          stream: frutasStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 40),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

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
