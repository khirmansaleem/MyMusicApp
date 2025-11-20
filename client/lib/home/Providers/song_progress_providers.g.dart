// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_progress_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SongPositionNotifier)
const songPositionProvider = SongPositionNotifierProvider._();

final class SongPositionNotifierProvider
    extends $NotifierProvider<SongPositionNotifier, Duration> {
  const SongPositionNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'songPositionProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$songPositionNotifierHash();

  @$internal
  @override
  SongPositionNotifier create() => SongPositionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$songPositionNotifierHash() =>
    r'ba755561a60db233005332ad673fa438605aa405';

abstract class _$SongPositionNotifier extends $Notifier<Duration> {
  Duration build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Duration, Duration>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Duration, Duration>, Duration, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SongDurationNotifier)
const songDurationProvider = SongDurationNotifierProvider._();

final class SongDurationNotifierProvider
    extends $NotifierProvider<SongDurationNotifier, Duration> {
  const SongDurationNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'songDurationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$songDurationNotifierHash();

  @$internal
  @override
  SongDurationNotifier create() => SongDurationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$songDurationNotifierHash() =>
    r'70ad576ea525f8778fddb30dfb3a8354420e3189';

abstract class _$SongDurationNotifier extends $Notifier<Duration> {
  Duration build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Duration, Duration>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Duration, Duration>, Duration, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
