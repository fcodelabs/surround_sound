import 'dart:math';

import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';

class SoundControllerImpl implements SoundController {
  final WebViewController _controller;
  final _rand = new Random();

  SoundControllerImpl(this._controller);

  @override
  Future<String> record(String data) {
    return _controller.evaluateJavascript(data);
  }

  @override
  Future<String> findName(String prefix) async {
    String vName;
    String result;
    do {
      final n = (_rand.nextDouble() * 1e10).toInt();
      vName = '$prefix$n';
      result = await record(vName);
    } while (result != 'null');
    return vName;
  }
}
