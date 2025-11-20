// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_songs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllSongs)
const getAllSongsProvider = GetAllSongsProvider._();

final class GetAllSongsProvider extends $FunctionalProvider<
        AsyncValue<List<SongModel>>, List<SongModel>, FutureOr<List<SongModel>>>
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  const GetAllSongsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getAllSongsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getAllSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getAllSongs(ref);
  }
}

String _$getAllSongsHash() => r'9b08061d47713d188e242ec213f4c8904d3e6731';
