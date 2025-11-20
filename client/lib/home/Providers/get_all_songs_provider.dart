import 'package:client/core/Failure/failure.dart';
import 'package:client/core/Providers/current_user_notifier.dart';
import 'package:client/home/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/song_model.dart';

part 'get_all_songs_provider.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final token = ref.watch(currentUserProvider)!.token;
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(
        token: token,
      );
  final val = switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
    Future<Either<AppFailure, List<SongModel>>>() => throw UnimplementedError(),
  };
  return val;
}
