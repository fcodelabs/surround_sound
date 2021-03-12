import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/web_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SoundWidget extends StatefulWidget {
  final SoundController soundController;
  final Color backgroundColor;

  const SoundWidget({
    Key? key,
    required this.soundController,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _SoundWidgetState createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  late String htmlText;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final color = widget.backgroundColor.value.toRadixString(16).substring(2);
    htmlText = 'data:text/html;base64,${base64Encode(
      const Utf8Encoder().convert(html('#$color')),
    )}';
  }

  @override
  void didUpdateWidget(SoundWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.backgroundColor != oldWidget.backgroundColor) {
      _init();
    }
  }

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
          widget.soundController.complete(controller);
        },
      ),
    );
  }
}
