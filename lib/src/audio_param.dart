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
