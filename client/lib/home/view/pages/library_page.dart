import 'package:client/core/Providers/current_song_notifier.dart';
import 'package:client/home/Providers/local_songs_provider.dart';
import 'package:client/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/music_player.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final librarySongs = ref.watch(localSongsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Library"),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadSongPage()),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F2F2F),
                  // same dark grey as screenshot
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18, // matches screenshot size
                    ),
                    SizedBox(width: 6),
                    Text(
                      "UPLOAD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
