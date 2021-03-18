import 'package:surround_sound/src/sound_controller.dart';
import 'package:surround_sound/src/tone/core/tone.dart';

abstract class ToneWithContext extends Tone {
  ToneWithContext({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
