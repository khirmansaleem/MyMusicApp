import 'package:client/home/repositories/recently_played_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';

part 'recently_played_songs_provider.g.dart';

@riverpod
class RecentlyPlayedSongs extends _$RecentlyPlayedSongs {
  @override
  List<SongModel> build() {
    return ref.read(recentlyPlayedRepositoryProvider).load();
  }

  Future<void> addSong(SongModel song) async {
    final repo = ref.read(recentlyPlayedRepositoryProvider);

    // generate unique key
    final key = "${song.id}_${DateTime.now().millisecondsSinceEpoch}";

    await repo.box.put(key, song);

    state = repo.box.values.toList().reversed.toList();
  }
}
