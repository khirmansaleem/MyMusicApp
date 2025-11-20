// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentSongNotifier)
const currentSongProvider = CurrentSongNotifierProvider._();

final class CurrentSongNotifierProvider
    extends $NotifierProvider<CurrentSongNotifier, SongModel?> {
  const CurrentSongNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'currentSongProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$currentSongNotifierHash();

  @$internal
  @override
  CurrentSongNotifier create() => CurrentSongNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongModel?>(value),
    );
  }
}

String _$currentSongNotifierHash() =>
    r'09061611486a3b58bca7c486d12a2b1001e757d2';

abstract class _$CurrentSongNotifier extends $Notifier<SongModel?> {
  SongModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SongModel?, SongModel?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SongModel?, SongModel?>, SongModel?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
