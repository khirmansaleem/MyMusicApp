import 'package:client/core/Providers/current_song_notifier.dart';
import 'package:client/core/widgets/loading_indicator.dart';
import 'package:client/home/Providers/get_all_songs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_pallete.dart';

class SongsPage extends ConsumerWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest today',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            ref.watch(getAllSongsProvider).when(
                  data: (songs) {
                    return SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          //here is the builder logic
                          final song = songs[index];
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(currentSongProvider.notifier)
                                  .updateSong(song);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          song.thumbnail_url,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.song_name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.artist,
                                      style: TextStyle(
                                        color: Pallete.subtitleText,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
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
                  error: (error, st) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  },
                  loading: () => const LoadingIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}
