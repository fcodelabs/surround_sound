import 'tone/core/tone.dart';

abstract class SoundController {
  SoundController._();

  Future<String> record(String data);

  Future<T> register<T extends Tone>();
}
