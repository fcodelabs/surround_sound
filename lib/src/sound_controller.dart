abstract class SoundController {
  SoundController._();

  Future<String> record(String data);

  Future<String> findName(String prefix);
}
