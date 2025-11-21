import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(Ref ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  // This box will only store USER library songs
  final Box<SongModel> libraryBox = Hive.box<SongModel>('library_songs');

  // Add a song to library (store only one song)
  Future<void> addToLibrary(SongModel song) async {
    await libraryBox.put(song.id, song);
  }

  // Load all library songs
  List<SongModel> loadLibrarySongs() {
    return libraryBox.values.cast<SongModel>().toList();
  }

  // Remove a song
  Future<void> removeFromLibrary(String songId) async {
    await libraryBox.delete(songId);
  }

  // Check if song already in library
  bool isInLibrary(String songId) {
    return libraryBox.containsKey(songId);
  }
}
