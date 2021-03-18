import '../../../sound_controller.dart';
import '../source.dart';

class Oscillator extends Source {
  static Future<Oscillator> def(SoundController controller,
      [int? frequency, String? type]) async {
    final vName = await controller.findName((Oscillator).toString());
    await controller
        .record('const $vName = new Tone.Oscillator($frequency, $type);');
    return Oscillator._(controller: controller, vName: vName);
  }

  Oscillator._({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
