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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surround Sound Example"),
      ),
      body: ListView(
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
          SizedBox(height: 32),
          ValueListenableBuilder<AudioParam>(
            valueListenable: _controller,
            builder: (context, value, _) {
              return Column(
                children: <Widget>[
                  Text("Volume"),
                  Slider(
                    value: value.volume,
                    min: 0,
                    max: 1,
                    onChanged: (val) {
                      _controller.setVolume(val);
                    },
                  ),
                  Text("Frequency"),
                  Slider(
                    value: value.freq,
                    min: 128,
                    max: 1500,
                    onChanged: (val) {
                      _controller.setFrequency(val);
                    },
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Position",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text("x-axis"),
                  Slider(
                    value: value.x,
                    min: -1,
                    max: 1,
                    onChanged: (val) {
                      _controller.setPosition(val, value.y, value.z);
                    },
                  ),
                  Text("y-axis"),
                  Slider(
                    value: value.y,
                    min: -1,
                    max: 1,
                    onChanged: (val) {
                      _controller.setPosition(value.x, val, value.z);
                    },
                  ),
                  Text("z-axis"),
                  Slider(
                    value: value.z,
                    min: -1,
                    max: 1,
                    onChanged: (val) {
                      _controller.setPosition(value.x, value.y, val);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
