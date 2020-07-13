import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'audio_param.dart';

class SoundController extends ValueNotifier<AudioParam> {
  final webController = Completer<WebViewController>();
  WebViewController _controller;

  SoundController() : super(AudioParam());

  set value(param) {
    setPosition(param.x, param.y, param.z);
    setFrequency(param.freq);
    setVolume(param.volume);
    super.value = param;
  }

  Future init() async {
    _controller = await webController.future;
    await _controller.evaluateJavascript('init_sound()');
  }

  Future _check() async {
    if (_controller == null) {
      await init();
    }
  }

  Future play() async {
    await _check();
    await _controller.evaluateJavascript('play()');
  }

  Future stop() async {
    await _check();
    await _controller.evaluateJavascript('stop()');
  }

  Future<bool> isPlaying() async {
    await _check();
    final started = await _controller.evaluateJavascript('started');
    return started?.toLowerCase()?.trim() == 'true';
  }

  Future setPosition(double x, double y, double z) async {
    await _check();
    x = x.clamp(-1, 1);
    y = y.clamp(-1, 1);
    z = z.clamp(-1, 1);
    await _controller.evaluateJavascript('set_panner('
        '${x * 4 + 30}, '
        '${y * 4 + 30}, '
        '${z * 4 + 300}'
        ');');
  }

  Future setFrequency(double freq) async {
    await _check();
    freq = freq.clamp(20, 20000);
    await _controller.evaluateJavascript('set_freq($freq);');
  }

  Future setVolume(double vol) async {
    await _check();
    vol = vol.clamp(0, 1);
    await _controller.evaluateJavascript('set_volume($vol);');
  }
}
