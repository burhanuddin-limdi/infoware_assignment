import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

AudioPlayer audioPlayer = AudioPlayer();

Future playOfflineMusic() async {
  await audioPlayer.setAsset('assets/audio/Song.mp3');
  audioPlayer.play();
}

pauseMusic() {
  audioPlayer.pause();
}

Stream<PositionData> get positionDataStream =>
    Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      audioPlayer.positionStream,
      audioPlayer.bufferedPositionStream,
      audioPlayer.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero),
    );

class PositionData {
  PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

String formatDuration(int milliseconds) {
  final duration = Duration(milliseconds: milliseconds);

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  var formattedDuration = '';

  if (hours > 0) {
    formattedDuration += '${hours.toString().padLeft(2, '0')}:';
  }

  formattedDuration += '${minutes.toString().padLeft(2, '0')}:';
  formattedDuration += seconds.toString().padLeft(2, '0');

  return formattedDuration;
}
