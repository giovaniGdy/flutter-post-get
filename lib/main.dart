import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Node server demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Client')),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String serverResponseGet = 'Server response';
  String serverResponsePost = 'Server response';

  //Coloque a porta que você está utilizando
  String link = 'http://10.0.2.2:porta/';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Send get to server'),
                onPressed: () {
                  _makeGetRequest();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverResponseGet),
              ),
              RaisedButton(
                child: Text('Send post to server'),
                onPressed: () {
                  _makePostTest();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverResponsePost),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _makePostTest() async {
    try {
      var uriRes = await post(link, body: {'post': 'node'});
      setState(() {
        serverResponsePost = uriRes.body;
      });
    } catch (e) {
      print(e);
    }
  }

  _makeGetRequest() async {
    Response response = await get(_localhost());
    setState(() {
      serverResponseGet = response.body;
    });
  }

  String _localhost() {
    if (Platform.isAndroid)
      return link;
    else // for iOS simulator
      return 'http://localhost:porta';
  }
}
