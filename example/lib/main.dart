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
  Simple2dGenerator gen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surround Sound Example"),
      ),
      body: ListView(
        children: <Widget>[
          SoundWidget(
            onSoundWidgetCreated: (controller) async {
              final _gen = await Simple2dGenerator.create(
                controller: controller,
                pan: 0,
                freq: 3000,
              );
              setState(() {
                gen = _gen;
              });
            },
          ),
          SizedBox(height: 32),
          if (gen != null)
            ValueListenableBuilder<Values2D>(
              valueListenable: gen,
              builder: (context, value, _) {
                return Column(children: [
                  MaterialButton(
                    onPressed: () async {
                      if (value.started) {
                        await gen.stop();
                      } else {
                        await gen.start();
                      }
                      setState(() {});
                    },
                    child: Text(value.started ? "Stop" : "Start"),
                  ),
                  SizedBox(height: 32),
                  Text("Frequency"),
                  SizedBox(height: 8),
                  Slider(
                    value: value.freq.toDouble(),
                    min: 3000,
                    max: 10000,
                    label: "Frequency",
                    onChanged: (val) => gen.changeFreq(val.toInt()),
                  ),
                  SizedBox(height: 16),
                  Text("Volume"),
                  SizedBox(height: 8),
                  Slider(
                    value: value.vol,
                    min: -25,
                    max: 5,
                    label: "Volume",
                    onChanged: (val) => gen.changeVol(val),
                  ),
                  SizedBox(height: 32),
                  Text("Left to Right"),
                  SizedBox(height: 8),
                  Slider(
                    value: value.pan,
                    min: -1,
                    max: 1,
                    label: "Panning",
                    onChanged: (val) => gen.changePan(val),
                  ),
                ]);
              },
            ),
        ],
      ),
    );
  }
}
