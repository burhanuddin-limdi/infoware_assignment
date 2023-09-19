import 'package:flutter/material.dart';
import 'package:infoware_assignment/services/audio_service.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool playing = false;
  @override
  void initState() {
    playing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder(
            stream: positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              if (positionData == null) return const SizedBox.shrink();

              return Slider(
                min: 0,
                value: positionData.position.inMilliseconds.toDouble(),
                max: positionData.duration.inMilliseconds.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    audioPlayer.seek(Duration(milliseconds: value.round()));
                  });
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              playing ? pauseMusic() : playOfflineMusic();
              setState(() {
                playing = !playing;
              });
            },
            icon: Icon(
              playing ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 60,
            ),
          )
        ],
      ),
    );
  }
}
