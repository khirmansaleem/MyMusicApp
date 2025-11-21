import 'package:hive/hive.dart';

import 'song_model.dart';

class SongModelAdapter extends TypeAdapter<SongModel> {
  @override
  final int typeId = 1; // must be unique

  @override
  SongModel read(BinaryReader reader) {
    final id = reader.readString();
    final songName = reader.readString();
    final artist = reader.readString();
    final thumbnail = reader.readString();
    final songUrl = reader.readString();
    final hexCode = reader.readString();

    return SongModel(
      id: id,
      song_name: songName,
      artist: artist,
      thumbnail_url: thumbnail,
      song_url: songUrl,
      hex_code: hexCode,
    );
  }

  @override
  void write(BinaryWriter writer, SongModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.song_name);
    writer.writeString(obj.artist);
    writer.writeString(obj.thumbnail_url);
    writer.writeString(obj.song_url);
    writer.writeString(obj.hex_code);
  }
}
