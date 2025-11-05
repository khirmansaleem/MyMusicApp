import 'dart:convert';

import 'package:client/auth/model/user_model.dart';
import 'package:client/core/Failure/failure.dart';
import 'package:client/core/constants/server_constants.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  // app network connection logic is here
  // api connection and routes
  Future<Either<AppFailure, UserModel>> signup({
    // fp_dart for handling wrong and right values
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${ServerConstant.ServerURL}/auth/signup'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                {'name': name, 'email': email, 'password': password},
              ));
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        // handle the error here
        return Left(AppFailure(resBodyMap['detail']));
      }

      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  //

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await http.post(Uri.parse('${ServerConstant.ServerURL}/auth/login'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                {'email': email, 'password': password},
              ));
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap['user']).copyWith(
        token: resBodyMap['token'],
      ));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

// authenticating token from the server side for login state persistence.
  Future<Either<AppFailure, UserModel>> getCurrentUserData({
    required String token,
  }) async {
    try {
      debugPrint('🌐 [RemoteAuth] Sending GET /auth with token: $token');

      final response = await http.get(
        Uri.parse('${ServerConstant.ServerURL}/auth/'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      debugPrint('🌐 [RemoteAuth] Response code: ${response.statusCode}');
      debugPrint('🌐 [RemoteAuth] Response body: ${response.body}');

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        debugPrint(
            '❌ [RemoteAuth] Failed to fetch user: ${resBodyMap['detail']}');
        return Left(
            AppFailure(resBodyMap['detail'] ?? 'Failed to fetch user data'));
      }

      final user = UserModel.fromMap(resBodyMap).copyWith(token: token);
      debugPrint('✅ [RemoteAuth] User fetched: ${user.email}');
      return Right(user);
    } catch (e, st) {
      debugPrint('💥 [RemoteAuth] Exception: $e\n$st');
      return Left(AppFailure(e.toString()));
    }
  }
}
