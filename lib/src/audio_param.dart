import 'package:meta/meta.dart';
import 'package:surround_sound/src/sound_controller.dart';

/// {@template audio_param}
/// Data model that can be used to transfer data between the app UI
/// and the sound source. Use with the [SoundController].
/// {@endtemplate}
@immutable
class AudioParam {
  /// Value from -1 to 1 where -1 being right side and 1 being left side
  final double x;

  /// Value from -1 to 1 where -1 being bottom and 1 being top
  final double y;

  /// Value from -1 to 1 where -1 being back and 1 being front
  final double z;

  /// Value from 20 to 20000 which controls the frequency of the
  /// sound source
  final double freq;

  /// Value from 0 to 1 which controls the volume of the sound
  /// source where 0 being mute and 1 being highest volume.
  final double volume;

  /// {@macro audio_param}
  AudioParam({
    this.x = 0,
    this.y = 0,
    this.z = 0,
    this.freq = 512,
    this.volume = 0.5,
  });

  /// Create a copy of the [AudioParam] with the given non-null values.
  AudioParam copyWith({
    double? x,
    double? y,
    double? z,
    double? freq,
    double? volume,
  }) {
    return AudioParam(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      freq: freq ?? this.freq,
      volume: volume ?? this.volume,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioParam &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          z == other.z &&
          freq == other.freq &&
          volume == other.volume;

  @override
  int get hashCode =>
      x.hashCode ^ y.hashCode ^ z.hashCode ^ freq.hashCode ^ volume.hashCode;
}
