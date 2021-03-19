import 'package:flutter/material.dart';
import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/tone/component/channel/panner.dart';
import 'package:surround_sound/src/tone/source/oscillator/oscillator.dart';

@immutable
class Values2D {
  final bool started;
  final double vol;
  final int freq;
  final double pan;

  Values2D({
    required this.started,
    required this.vol,
    required this.freq,
    required this.pan,
  });

  Values2D clone({
    bool? started,
    double? vol,
    int? freq,
    double? pan,
  }) {
    return Values2D(
      started: started ?? this.started,
      vol: vol ?? this.vol,
      freq: freq ?? this.freq,
      pan: pan ?? this.pan,
    );
  }
}

class Simple2dGenerator extends ValueNotifier<Values2D> {
  final SoundController _controller;
  final Panner _panner;
  final Oscillator _osc;

  Simple2dGenerator._(
    this._controller,
    this._panner,
    this._osc,
    int freq,
    double pan,
  ) : super(Values2D(
          started: false,
          vol: 0,
          freq: freq,
          pan: pan,
        ));

  static Future<Simple2dGenerator> create({
    required SoundController controller,
    required double pan,
    required int freq,
  }) async {
    final panner = await Panner.def(controller, pan);
    await controller.record('${panner.vName}.toDestination();');
    final osc = await Oscillator.def(controller, freq);
    await controller.record('${osc.vName}.connect(${panner.vName});');
    return Simple2dGenerator._(controller, panner, osc, freq, pan);
  }

  Future start() async {
    await _controller.record('${_osc.vName}.start();');
    value = value.clone(started: true);
  }

  Future stop() async {
    await _controller.record('${_osc.vName}.stop();');
    value = value.clone(started: false);
  }

  Future changeFreq(int freq) async {
    await _controller.record('${_osc.vName}.frequency.value=$freq');
    value = value.clone(freq: freq);
  }

  Future changeVol(double vol) async {
    await _controller.record('${_osc.vName}.volume.value=$vol');
    value = value.clone(vol: vol);
  }

  Future changePan(double pan) async {
    await _controller.record('${_panner.vName}.pan.value=$pan');
    value = value.clone(pan: pan);
  }
}
