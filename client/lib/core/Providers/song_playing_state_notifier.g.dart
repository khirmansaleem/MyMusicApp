// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_playing_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SongPlayStateNotifier)
const songPlayStateProvider = SongPlayStateNotifierProvider._();

final class SongPlayStateNotifierProvider
    extends $NotifierProvider<SongPlayStateNotifier, bool> {
  const SongPlayStateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'songPlayStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$songPlayStateNotifierHash();

  @$internal
  @override
  SongPlayStateNotifier create() => SongPlayStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$songPlayStateNotifierHash() =>
    r'b6bcb99a887b49593fab48d60c61cf3e62f84600';

abstract class _$SongPlayStateNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
