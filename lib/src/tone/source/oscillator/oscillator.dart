import '../../../sound_controller.dart';
import '../source.dart';

class Oscillator extends Source {
  static Future<Oscillator> def(
    SoundController controller, [
    int frequency = 100,
    String type = 'sine',
  ]) async {
    final cName = (Oscillator).toString();
    final vName = await controller.findName(cName);
    await controller
        .record('const $vName = new Tone.$cName($frequency, "$type");');
    return Oscillator._(controller: controller, vName: vName);
  }

  Oscillator._({required SoundController controller, required String vName})
      : super(controller: controller, vName: vName);
}
