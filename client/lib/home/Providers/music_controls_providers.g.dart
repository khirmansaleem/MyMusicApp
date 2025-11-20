// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_controls_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Shuffle)
const shuffleProvider = ShuffleProvider._();

final class ShuffleProvider extends $NotifierProvider<Shuffle, bool> {
  const ShuffleProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'shuffleProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$shuffleHash();

  @$internal
  @override
  Shuffle create() => Shuffle();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$shuffleHash() => r'dc0873bc7b6d331fe36063df94fe8e86505c5306';

abstract class _$Shuffle extends $Notifier<bool> {
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

@ProviderFor(Repeat)
const repeatProvider = RepeatProvider._();

final class RepeatProvider extends $NotifierProvider<Repeat, bool> {
  const RepeatProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'repeatProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$repeatHash();

  @$internal
  @override
  Repeat create() => Repeat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$repeatHash() => r'f0c6edb0fa42f2d7235fc5b6c191888f27cd9a04';

abstract class _$Repeat extends $Notifier<bool> {
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
