import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';

class SoundControllerImpl implements SoundController {
  WebViewController? _controller;
  bool _mChannel = false;
  final _initializeCompleter = Completer<bool>();

  bool get mChannel => _mChannel;
  set mChannel(bool mChannel) {
    _mChannel = mChannel;
    _setCompleter();
  }

  WebViewController? get controller => _controller;
  set controller(WebViewController? controller) {
    _controller = controller;
    _setCompleter();
  }

  void _setCompleter() {
    if (_mChannel && _controller != null) {
      _initializeCompleter.complete(true);
    }
  }

  @override
  Future<bool> initialized() {
    return _initializeCompleter.future;
  }
}
