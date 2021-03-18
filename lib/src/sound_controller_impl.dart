import 'package:webview_flutter/webview_flutter.dart';

import './sound_controller.dart';

class SoundControllerImpl implements SoundController {
  final WebViewController _controller;

  SoundControllerImpl(this._controller);
}
