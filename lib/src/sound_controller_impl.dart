import 'dart:async';
import 'dart:math';

import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';

class SoundControllerImpl implements SoundController {
  final WebViewController _controller;
  final _rand = new Random();
  Completer<bool>? _cmp;

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

  Future<bool> initialize() {
    if (_cmp != null) return _cmp!.future;
    _cmp = Completer<bool>();
    Future.microtask(() async {
      String? val;
      while (true) {
        val = await record('1+1');
        if (val == '2') {
          _cmp!.complete();
          break;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    });
    return _cmp!.future;
  }
}
