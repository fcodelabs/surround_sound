import 'dart:async';

abstract class SoundController {
  SoundController._();

  Future<bool> initialized();
}
