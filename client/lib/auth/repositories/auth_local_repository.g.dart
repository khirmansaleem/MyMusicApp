// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authLocalRepository)
const authLocalRepositoryProvider = AuthLocalRepositoryProvider._();

final class AuthLocalRepositoryProvider extends $FunctionalProvider<
        AsyncValue<AuthLocalRepository>,
        AuthLocalRepository,
        FutureOr<AuthLocalRepository>>
    with
        $FutureModifier<AuthLocalRepository>,
        $FutureProvider<AuthLocalRepository> {
  const AuthLocalRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authLocalRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authLocalRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<AuthLocalRepository> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AuthLocalRepository> create(Ref ref) {
    return authLocalRepository(ref);
  }
}

String _$authLocalRepositoryHash() =>
    r'd7c8058bcdade283be77c3816975585cc1dfe184';
