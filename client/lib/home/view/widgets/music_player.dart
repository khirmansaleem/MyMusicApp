import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/Providers/current_song_notifier.dart';
import '../../../core/Providers/song_playing_state_notifier.dart';
import '../../../core/theme/app_pallete.dart';
import '../../Providers/music_controls_providers.dart';
import '../../Providers/song_progress_providers.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final isPlaying = ref.watch(songPlayStateProvider);
    final position = ref.watch(songPositionProvider);
    final duration = ref.watch(songDurationProvider);
    final isShuffleOn = ref.watch(shuffleProvider);
    final isRepeatOn = ref.watch(repeatProvider);

    // Ensure duration is never zero
    final total = duration.inSeconds;
    final current = position.inSeconds;

// TEMP FIX: Prevent position from going beyond duration
    final boundedPosition = current > total ? total : current;

// Now safe values
    final safeMax = total > 0 ? total.toDouble() : 1.0;
    final safeValue = boundedPosition.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text(currentSong!.song_name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Thumbnail
          Container(
            height: 240,
            width: 240,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(currentSong.thumbnail_url),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 40),

          // Song name & artist
          Text(
            currentSong.song_name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            currentSong.artist,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 30),

          // Slider
          Slider(
            value: safeValue,
            min: 0,
            max: safeMax,
            onChanged: (value) {
              ref
                  .read(currentSongProvider.notifier)
                  .seek(Duration(seconds: value.toInt()));
            },
          ),

          Text(
              "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}"),

          const SizedBox(height: 40),

          // ENTIRE CONTROL ROW (same positions, no overflow)
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SHUFFLE
                IconButton(
                  icon: Icon(
                    CupertinoIcons.shuffle,
                    color: isShuffleOn
                        ? Pallete.whiteColor
                        : Pallete.inactiveSeekColor,
                  ),
                  iconSize: 26,
                  onPressed: () {
                    ref.read(shuffleProvider.notifier).toggle();
                    ref
                        .read(currentSongProvider.notifier)
                        .audioPlayer!
                        .setShuffleModeEnabled(!isShuffleOn);
                  },
                ),

                // BACKWARD 10 SEC
                IconButton(
                  icon: const Icon(CupertinoIcons.gobackward_10),
                  iconSize: 28,
                  onPressed: () {
                    ref
                        .read(currentSongProvider.notifier)
                        .seek(position - const Duration(seconds: 10));
                  },
                ),

                // PREVIOUS SONG
                IconButton(
                  icon: const Icon(CupertinoIcons.backward_end_alt_fill),
                  iconSize: 32,
                  onPressed: () {
                    ref.read(currentSongProvider.notifier).playPreviousSong();
                  },
                ),

                // PLAY / PAUSE
                IconButton(
                  icon: Icon(
                    isPlaying
                        ? CupertinoIcons.pause_circle_fill
                        : CupertinoIcons.play_circle_fill,
                  ),
                  iconSize: 66, // slightly smaller to avoid overflow
                  onPressed: () {
                    ref.read(currentSongProvider.notifier).togglePlayPause();
                  },
                ),

                // NEXT SONG
                IconButton(
                  icon: const Icon(CupertinoIcons.forward_end_alt_fill),
                  iconSize: 32,
                  onPressed: () {
                    ref.read(currentSongProvider.notifier).playNextSong();
                  },
                ),

                // FORWARD 10 SEC
                IconButton(
                  icon: const Icon(CupertinoIcons.goforward_10),
                  iconSize: 28,
                  onPressed: () {
                    ref
                        .read(currentSongProvider.notifier)
                        .seek(position + const Duration(seconds: 10));
                  },
                ),

                // REPEAT
                IconButton(
                  icon: Icon(
                    isRepeatOn
                        ? CupertinoIcons.repeat_1
                        : CupertinoIcons.repeat,
                    color: isRepeatOn
                        ? Pallete.whiteColor
                        : Pallete.inactiveSeekColor,
                  ),
                  iconSize: 26,
                  onPressed: () {
                    ref.read(repeatProvider.notifier).toggle();
                    ref
                        .read(currentSongProvider.notifier)
                        .audioPlayer!
                        .setLoopMode(
                          isRepeatOn ? LoopMode.off : LoopMode.one,
                        );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
