import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';


class SoundController {
  final webController = Completer<WebViewController>();
  WebViewController _controller;

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

}
