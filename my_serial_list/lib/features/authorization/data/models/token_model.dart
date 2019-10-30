import 'package:meta/meta.dart';
import 'package:my_serial_list/features/authorization/domain/entities/user/token.dart';

class TokenModel extends Token {
  TokenModel({@required String token});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      TokenModel(token: json['token']);

  Map<String, dynamic> toJson() => {'token': token};
}
