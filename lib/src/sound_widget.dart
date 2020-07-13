import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/web_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SoundWidget extends StatefulWidget {
  final SoundController soundController;

  SoundWidget({
    Key key,
    @required this.soundController,
  })
      : assert(soundController != null),
        super(key: key);

  @override
  _SoundWidgetState createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  final htmlText = 'data:text/html;base64,${base64Encode(
      const Utf8Encoder().convert(html))}';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: 1,
      child: WebView(
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: htmlText,
        onWebViewCreated: (controller) {
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${controller
              .runtimeType}");
          widget.soundController.webController.complete(controller);
        },
      ),
    );
  }
}
