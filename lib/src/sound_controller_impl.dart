import 'dart:math';

import 'package:surround_sound/src/tone/core/tone.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';
import 'tone/core/context/tone_with_context.dart';

class SoundControllerImpl implements SoundController {
  final WebViewController _controller;
  final _rand = new Random();

  SoundControllerImpl(this._controller);

  @override
  Future<String> record(String data) {
    return _controller.evaluateJavascript(data);
  }

  Future<String> _initialize(String type) async {
    final name = type.toLowerCase();
    String vName;
    String result;
    do {
      final n = (_rand.nextDouble() * 1e10).toInt();
      vName = '$name$n';
      result = await record(vName);
    } while (result != 'null');
    await record('const $vName = new Tone.$type();');
    return vName;
  }

  @override
  Future<T> register<T extends Tone>() async {
    final name = await _initialize(T.toString());
    switch (T) {
      case ToneWithContext:
        return ToneWithContext(controller: this, name: name) as T;

      default:
        throw "Generics doesn't match any of the Tone Types ($T)";
    }
  }
}
