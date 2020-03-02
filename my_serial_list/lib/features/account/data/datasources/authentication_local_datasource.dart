import 'dart:convert';

import 'package:my_serial_list/core/error/exceptions.dart';
import 'package:my_serial_list/features/account/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const CACHED_TOKEN = "CACHED_TOKEN";
const CACHED_USERNAME = "CACHED_USERNAME";

abstract class AuthenticationLocalDataSource {
  /// Get cached token
  ///
  /// Throws a [CacheException] if token not exsist
  Future<TokenModel> getToken();
  Future<String> getUsername();

  /// Cache Token
  Future cacheToken(TokenModel token);

  Future cacheUsername(String username);

  Future removeTokenAndUsername();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future cacheToken(TokenModel token) async {
    return sharedPreferences.setString(
        CACHED_TOKEN, json.encode(token.toJson()));
  }

  @override
  Future<TokenModel> getToken() {
    String stringToken = sharedPreferences.getString(CACHED_TOKEN);
    if (stringToken != null) {
      return Future.value(TokenModel.fromJson(json.decode(stringToken)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future cacheUsername(String username) {
    return sharedPreferences.setString(CACHED_USERNAME, username);
  }

  @override
  Future<String> getUsername() {
    String stringUsername = sharedPreferences.getString(CACHED_USERNAME);
    if (stringUsername != null) {
      return Future.value(stringUsername);
    } else {
      throw CacheException();
    }
  }

  @override
  Future removeTokenAndUsername() {
    sharedPreferences.remove(CACHED_USERNAME);
    sharedPreferences.remove(CACHED_TOKEN);
    return Future(null);
  }
}
