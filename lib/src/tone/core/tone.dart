import 'package:surround_sound/src/sound_controller.dart';

///The exported Tone object. Contains all of the classes that default to the
///same context and contains a singleton Transport and Destination node.
abstract class Tone {
  final SoundController controller;
  final String vName;

  Tone({required this.controller, required this.vName});
}
