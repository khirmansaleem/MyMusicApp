import 'package:client/core/Providers/current_song_notifier.dart';
import 'package:client/core/widgets/loading_indicator.dart';
import 'package:client/home/Providers/get_all_songs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_pallete.dart';
import '../../Providers/local_songs_provider.dart';
import '../../Providers/recently_played_songs_provider.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayed = ref.watch(recentlyPlayedSongsProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        // bottom = 120 to avoid overlap with MusicSlab
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------
            // ⭐ LATEST TODAY TITLE
            // ------------------------------
            const Text(
              'Latest today',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            // ------------------------------
            // ⭐ LATEST TODAY LIST
            // ------------------------------
            ref.watch(getAllSongsProvider).when(
                  data: (songs) {
                    return SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return GestureDetector(
                            onTap: () async {
                              await ref
                                  .read(currentSongProvider.notifier)
                                  .updateSong(song);
                              await ref
                                  .read(localSongsProvider.notifier)
                                  .addSong(song);
                              await ref
                                  .read(recentlyPlayedSongsProvider.notifier)
                                  .addSong(song);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Thumbnail
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                        image: NetworkImage(song.thumbnail_url),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  // Song name
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.song_name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  // Artist
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.artist,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Pallete.subtitleText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, st) => Center(child: Text(error.toString())),
                  loading: () => const LoadingIndicator(),
                ),

            const SizedBox(height: 25),

            // ------------------------------
            // ⭐ RECENTLY PLAYED (NEW SECTION)
            // ------------------------------
            const Text(
              "Recently Played",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (recentlyPlayed.isNotEmpty) ...[
              // ⭐ Vertical list (multiple items)
              ListView.builder(
                shrinkWrap: true,
                // ⭐ Important for vertical list inside Column
                physics: NeverScrollableScrollPhysics(),
                // ⭐ So it scrolls with SongsPage
                itemCount: recentlyPlayed.length,
                itemBuilder: (context, index) {
                  final song = recentlyPlayed[index];

                  return GestureDetector(
                    onTap: () {
                      ref.read(currentSongProvider.notifier).updateSong(song);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              song.thumbnail_url,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Text Area
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.song_name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song.artist,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Pallete.subtitleText,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),
            ],
          ],
        ),
      ),
    );
  }
}
