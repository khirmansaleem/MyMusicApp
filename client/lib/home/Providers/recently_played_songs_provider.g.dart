// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_songs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecentlyPlayedSongs)
const recentlyPlayedSongsProvider = RecentlyPlayedSongsProvider._();

final class RecentlyPlayedSongsProvider
    extends $NotifierProvider<RecentlyPlayedSongs, List<SongModel>> {
  const RecentlyPlayedSongsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recentlyPlayedSongsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recentlyPlayedSongsHash();

  @$internal
  @override
  RecentlyPlayedSongs create() => RecentlyPlayedSongs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SongModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SongModel>>(value),
    );
  }
}

String _$recentlyPlayedSongsHash() =>
    r'32353648adf694130088bae60743924cc55366d2';

abstract class _$RecentlyPlayedSongs extends $Notifier<List<SongModel>> {
  List<SongModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<SongModel>, List<SongModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<SongModel>, List<SongModel>>,
        List<SongModel>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
