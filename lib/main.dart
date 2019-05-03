import 'package:flutter/material.dart';
import './endgame_screens/home_endgame.dart';

void main() => runApp(new EndgameApp());

class EndgameApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "I'm Thanos",
      home: Scaffold(
        appBar: AppBar(title: Text("Endgame ending is"),
        ),
        body: InfinitySaga(title: 'Endgame'),
      )
    );
  }
}

