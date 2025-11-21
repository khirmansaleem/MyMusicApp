import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';
import '../repositories/home_local_repository.dart';

part 'local_songs_provider.g.dart';

@riverpod
class LocalSongs extends _$LocalSongs {
  @override
  List<SongModel> build() {
    final repo = ref.read(homeLocalRepositoryProvider); // ← should work now
    return repo.loadLibrarySongs();
  }

  Future<void> addSong(SongModel song) async {
    final repo = ref.read(homeLocalRepositoryProvider);
    if (repo.isInLibrary(song.id)) return;
    await repo.addToLibrary(song);
    state = repo.loadLibrarySongs();
  }

  Future<void> removeSong(String id) async {
    final repo = ref.read(homeLocalRepositoryProvider);
    await repo.removeFromLibrary(id);
    state = repo.loadLibrarySongs();
  }
}
