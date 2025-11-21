// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recentlyPlayedRepository)
const recentlyPlayedRepositoryProvider = RecentlyPlayedRepositoryProvider._();

final class RecentlyPlayedRepositoryProvider extends $FunctionalProvider<
    RecentlyPlayedRepository,
    RecentlyPlayedRepository,
    RecentlyPlayedRepository> with $Provider<RecentlyPlayedRepository> {
  const RecentlyPlayedRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'recentlyPlayedRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$recentlyPlayedRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecentlyPlayedRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecentlyPlayedRepository create(Ref ref) {
    return recentlyPlayedRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentlyPlayedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentlyPlayedRepository>(value),
    );
  }
}

String _$recentlyPlayedRepositoryHash() =>
    r'0e7a92c761ebb82b3aedcb26f4e71f1a661150c6';
