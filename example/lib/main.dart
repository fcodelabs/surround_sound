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
  final _controller = SoundController();
  double val=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surround Sound Example"),
      ),
      body: Column(
        children: <Widget>[
          SoundWidget(soundController: _controller),
          SizedBox(height: 32),
          FlatButton(
            child: Text("Play"),
            onPressed: () {
              _controller.play();
            },
          ),
          Slider(
            value: val,
            min: -1,
            max: 1,
            onChanged: (val) {
              setState(() {
                this.val = val;
              });
              _controller.setPosition(val, 0, 0);
            },
          ),
        ],
      ),
    );
  }
}
