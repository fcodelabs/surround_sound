import 'package:surround_sound/src/tone/core/context/tone_audio_node.dart';

import '../../sound_controller.dart';

abstract class Source extends ToneAudioNode {
  Source({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
