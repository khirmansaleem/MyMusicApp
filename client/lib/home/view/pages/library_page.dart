import 'package:client/core/Providers/current_song_notifier.dart';
import 'package:client/home/Providers/local_songs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/music_player.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final librarySongs = ref.watch(localSongsProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Liked Songs")),
      body: librarySongs.isEmpty
          ? Center(child: Text("No songs in your library yet"))
          : ListView.builder(
              itemCount: librarySongs.length,
              itemBuilder: (context, index) {
                final song = librarySongs[index];

                return ListTile(
                  leading: Image.network(song.thumbnail_url),
                  title: Text(song.song_name),
                  subtitle: Text(song.artist),
                  onTap: () {
                    // 1️⃣ Play the song
                    ref.read(currentSongProvider.notifier).updateSong(song);

                    // 2️⃣ Navigate to MusicPlayer page
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (_, animation, __) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1), // Slide from bottom
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                            child: const MusicPlayer(),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
