import 'dart:convert';
import 'dart:io';

import 'package:client/core/Failure/failure.dart';
import 'package:client/core/constants/server_constants.dart';
import 'package:client/home/model/song_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  // upload songs
  Future<Either<AppFailure, String>> UploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ServerConstant.ServerURL}/songs/upload-song'),
      );
      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath(
              'song',
              selectedAudio.path,
            ),
            await http.MultipartFile.fromPath(
              'thumbnail',
              selectedThumbnail.path,
            ),
          ],
        )
        ..fields.addAll(
          {'artist': artist, 'song_name': songName, 'hex_code': hexCode},
        )
        ..headers.addAll(
          {
            'x-auth-token': token,
          },
        );
      final res = await request.send();
      print(res);
      if (res.statusCode != 201) {
        return Left(AppFailure(await res.stream.bytesToString()));
      }
      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs({
    required String token,
  }) async {
    try {
      final url = Uri.parse("${ServerConstant.ServerURL}/songs/list");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // Add token if needed:
          "x-auth-token": token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);

        final List<SongModel> songs =
            decoded.map((e) => SongModel.fromMap(e)).toList();

        return Right(songs);
      }
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      return Left(
        AppFailure(resBodyMap['detail']),
      );
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
