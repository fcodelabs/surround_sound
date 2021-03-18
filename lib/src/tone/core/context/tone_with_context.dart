import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/tone/core/tone.dart';

class ToneWithContext extends Tone {
  ToneWithContext({required SoundController controller, required String name})
      : super(controller: controller, name: name);
}
