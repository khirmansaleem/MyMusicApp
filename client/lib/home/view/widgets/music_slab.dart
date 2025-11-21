import 'package:client/core/Providers/current_song_notifier.dart';
import 'package:client/core/Providers/song_playing_state_notifier.dart';
import 'package:client/core/utils.dart';
import 'package:client/home/Providers/local_songs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_pallete.dart';
import '../../Providers/song_progress_providers.dart';
import 'music_player.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final isPlaying = ref.watch(songPlayStateProvider);

    if (currentSong == null) {
      return SizedBox();
    }
    return GestureDetector(
      onTap: () {
        final currentSong = ref.read(currentSongProvider); // SongModel?

        if (currentSong == null) return; // Nothing is playing yet

        // 1️⃣ Add current song to library
        ref.read(localSongsProvider.notifier).addSong(currentSong);
        //
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (_, animation, __) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1), // bottom
                  end: Offset.zero, // current screen
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: const MusicPlayer(),
              );
            },
          ),
        );
      },
      child: Stack(children: [
        Container(
          height: 66,
          width: MediaQuery.of(context).size.width - 16,
          decoration: BoxDecoration(
            color: hexToColor(currentSong.hex_code),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 66,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                            currentSong.thumbnail_url,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSong.song_name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          currentSong.artist,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Pallete.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Icons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.heart),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(currentSongProvider.notifier).togglePlayPause();
                    },
                    icon: Icon(isPlaying
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_fill),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 8,
          // We wrap this bar in Consumer so it rebuilds when Riverpod providers update.
          child: Consumer(
            builder: (context, ref, _) {
              // 🔹 READ current playback position (e.g. 00:45)
              final position = ref.watch(songPositionProvider);

              // 🔹 READ total duration of the song (e.g. 03:12)
              final duration = ref.watch(songDurationProvider);

              // 🔹 The total width of the progress bar background (gray bar)
              final totalWidth = MediaQuery.of(context).size.width - 32;

              // 🔹 Calculate 0.0 to 1.0 percentage of progress
              //    Example: 45 seconds / 180 seconds = 0.25 (25% progress)
              final progress = (duration.inMilliseconds == 0)
                  ? 0.0 // Avoid division error before song is loaded
                  : position.inMilliseconds / duration.inMilliseconds;

              // 🔹 Return the white progress bar whose width grows over time
              return Container(
                height: 2,

                // ❗ THIS IS THE ONLY CHANGE YOU NEEDED
                // Width = total possible width * progress %
                width: totalWidth * progress,

                decoration: BoxDecoration(
                  color: Pallete.whiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 8,
          child: Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              color: Pallete.inactiveSeekColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ]),
    );
  }
}
