// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_songs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalSongs)
const localSongsProvider = LocalSongsProvider._();

final class LocalSongsProvider
    extends $NotifierProvider<LocalSongs, List<SongModel>> {
  const LocalSongsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localSongsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$localSongsHash();

  @$internal
  @override
  LocalSongs create() => LocalSongs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SongModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SongModel>>(value),
    );
  }
}

String _$localSongsHash() => r'334e1efcc55ba183ebe4f084acb740eec58cb217';

abstract class _$LocalSongs extends $Notifier<List<SongModel>> {
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
