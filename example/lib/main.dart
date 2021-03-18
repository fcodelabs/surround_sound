import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surround_sound/surround_sound.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surround Sound Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surround Sound Example"),
      ),
      body: ListView(
        children: <Widget>[
          SoundWidget(
            onSoundWidgetCreated: (controller) {},
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
