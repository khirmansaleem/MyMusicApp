import 'dart:io';
import 'dart:ui';

import 'package:client/core/Providers/current_user_notifier.dart';
import 'package:client/home/repositories/home_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/utils.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;

  //
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color color,
  }) async {
    String hexCode = colorToHex(color);
    state = const AsyncValue.loading();

    final currentUser = ref.read(currentUserProvider);
    final token = currentUser!.token;

    final response = await _homeRepository.UploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: hexCode,
      token: token,
    );

    final val = switch (response) {
      Left(value: final l) => state = AsyncValue.error(l, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }
}
