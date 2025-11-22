import 'package:client/core/Providers/song_playing_state_notifier.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/Providers/get_all_songs_provider.dart';
import '../../home/Providers/song_progress_providers.dart';
import '../../home/model/song_model.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? audioPlayer;

  @override
  SongModel? build() {
    return null;
  }

  void seek(Duration position) {
    audioPlayer?.seek(position);
  }

  void playNextSong() {
    final songs = ref.read(getAllSongsProvider).value!;
    final currentIndex = songs.indexOf(state!);

    if (currentIndex < songs.length - 1) {
      updateSong(songs[currentIndex + 1]);
    }
  }

  void playPreviousSong() {
    final songs = ref.read(getAllSongsProvider).value!;
    final currentIndex = songs.indexOf(state!);

    if (currentIndex > 0) {
      updateSong(songs[currentIndex - 1]);
    }
  }

  // one function that allow toggling between musics

  Future<void> updateSong(SongModel song) async {
    // Create only once
    audioPlayer ??= AudioPlayer();

    // STOP instead of dispose
    await audioPlayer!.stop();

    // Set listeners ONLY once
    audioPlayer!.durationStream.listen((duration) {
      if (duration != null) {
        ref.read(songDurationProvider.notifier).update(duration);
      }
    });

    audioPlayer!.positionStream.listen((position) {
      ref.read(songPositionProvider.notifier).update(position);
    });

    audioPlayer!.playerStateStream.listen((state) {
      ref.read(songPlayStateProvider.notifier).setPlaying(state.playing);
    });

    // Load and play
    await audioPlayer!.setAudioSource(
      AudioSource.uri(Uri.parse(song.song_url)),
    );

    await audioPlayer!.play();

    state = song;
    ref.read(songPlayStateProvider.notifier).setPlaying(true);
  }

  // Toggling play and pause
  Future<void> togglePlayPause() async {
    final playing = ref.read(songPlayStateProvider);

    if (playing) {
      audioPlayer!.pause();
      ref.read(songPlayStateProvider.notifier).setPlaying(false);
    } else {
      audioPlayer!.play();
      ref.read(songPlayStateProvider.notifier).setPlaying(true);
    }
  }
}
