import 'dart:async';
import 'dart:math';

import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';

class SoundControllerImpl implements SoundController {
  final WebViewController _controller;
  final _rand = new Random();
  final _vNames = <String>[];
  Completer<bool>? _cmp;

  SoundControllerImpl(this._controller);

  @override
  Future<String> record(String data) async {
    try {
      return await _controller.evaluateJavascript(data);
    } catch (e) {
      print("Executing JS resulted an error.\n\n$e");
      return 'Error: $e';
    }
  }

  @override
  Future<String> findName(String prefix) async {
    prefix = prefix.toLowerCase();
    String vName;
    while (true) {
      final n = (_rand.nextDouble() * 1e10).toInt();
      vName = '$prefix$n';
      if (!_vNames.contains(vName)) {
        _vNames.add(vName);
        return vName;
      }
    }
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
          print("Sound Controller initialization done !!!");
          break;
        }
        print("Sound Controller initialization failed. Retrying...");
        await Future.delayed(Duration(seconds: 1));
      }
    });
    return _cmp!.future;
  }
}
