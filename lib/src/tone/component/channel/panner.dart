import 'package:surround_sound/surround_sound.dart';

class Panner extends ToneAudioNode {
  static Future<Panner> def(SoundController controller, [double? pan]) async {
    if (pan != null) {
      assert(0 >= pan && pan >= 1);
    }
    final cName = (Panner).toString();
    final vName = await controller.findName(cName);
    await controller.record('const $vName = new Tone.$cName($pan);');
    return Panner._(controller: controller, vName: vName);
  }

  Panner._({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
