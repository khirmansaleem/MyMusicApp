import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';

part 'recently_played_repository.g.dart';

@riverpod
RecentlyPlayedRepository recentlyPlayedRepository(Ref ref) {
  return RecentlyPlayedRepository();
}

class RecentlyPlayedRepository {
  Box<SongModel> get box => Hive.box<SongModel>('recently_played');

  Future<void> add(SongModel song) async {
    // Remove old entry to avoid duplicates
    await box.delete(song.id);

    // Add it again → moves to top
    await box.put(song.id, song);
  }

  List<SongModel> load() {
    return box.values.toList().reversed.toList();
  }
}
