import 'package:meta/meta.dart';
import 'package:my_serial_list/features/account/domain/entities/user/token.dart';

class TokenModel extends Token {
  final String token;
  TokenModel({@required this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      TokenModel(token: json['token']);

  Map<String, dynamic> toJson() => {'token': token};
}
