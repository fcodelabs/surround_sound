import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/sound_controller_impl.dart';
import 'package:surround_sound/src/web_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef SoundWidgetCreatedCallback = void Function(SoundController controller);

class SoundWidget extends StatelessWidget {
  final SoundWidgetCreatedCallback onSoundWidgetCreated;

  const SoundWidget({
    Key? key,
    required this.onSoundWidgetCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final htmlText = 'data:text/html;base64,${base64Encode(
      const Utf8Encoder().convert(html),
    )}';


    return Visibility(
      visible: true,
      maintainState: true,
      child: SizedBox(
        height: 1,
        width: 1,
        child: WebView(
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: htmlText,
          onWebViewCreated: (controller) {
            final soundController = SoundControllerImpl(controller);
            onSoundWidgetCreated(soundController);
          },
        ),
      ),
    );
  }
}
