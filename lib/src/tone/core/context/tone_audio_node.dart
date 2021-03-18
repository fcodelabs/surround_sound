import 'package:surround_sound/src/tone/tone_ex.dart';

import '../../../sound_controller.dart';

abstract class ToneAudioNode extends ToneWithContext {
  ToneAudioNode({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
