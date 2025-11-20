import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(Ref ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box<SongModel> box = Hive.box<SongModel>('songs');

  Future<void> uploadSongs(List<SongModel> songs) async {
    await box.clear();
    await box.addAll(songs);
  }

  List<SongModel> loadSongs() {
    return box.values.cast<SongModel>().toList();
  }
}
