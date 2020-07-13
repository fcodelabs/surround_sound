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
  final _controller = SoundController();
  double val = 256;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("Play"),
                onPressed: () async {
                  await _controller.play();
                  final val = await _controller.isPlaying();
                  print('isPlaying: $val');
                },
              ),
              SizedBox(width: 24),
              FlatButton(
                child: Text("Stop"),
                onPressed: () async {
                  await _controller.stop();
                  final val = await _controller.isPlaying();
                  print('isPlaying: $val');
                },
              ),
            ],
          ),
          Slider(
            value: val,
            min: 256,
            max: 1500,
            onChanged: (val) {
              _controller.setFrequency(val);
              setState(() {
                this.val = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
