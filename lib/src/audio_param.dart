import 'package:meta/meta.dart';

@immutable
class AudioParam {
  final double x;
  final double y;
  final double z;
  final double freq;
  final double volume;

  AudioParam({
    this.x = 0,
    this.y = 0,
    this.z = 0,
    this.freq = 512,
    this.volume = 0.5,
  });

  AudioParam copyWith({
    double x,
    double y,
    double z,
    double freq,
    double volume,
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
