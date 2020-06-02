import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:receptio/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required nickname,
    @required name,
    @required picture,
    @required updated_at,
    @required email,
    @required email_verified,
    @required iss,
    @required sub,
    @required aud,
    @required iat,
    @required exp,
  }) : super(
          nickname: nickname,
          name: name,
          picture: picture,
          updated_at: updated_at,
          email: email,
          email_verified: email_verified,
          iss: iss,
          sub: sub,
          aud: aud,
          iat: iat,
          exp: exp,
        );

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'name': name,
      'picture': picture,
      'updated_at': updated_at,
      'email': email,
      'email_verified': email_verified,
      'iss': iss,
      'sub': sub,
      'aud': aud,
      'iat': iat,
      'exp': exp,
    };
  }

  static UserModel fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      nickname: map['nickname'],
      name: map['name'],
      picture: map['picture'],
      updated_at: map['updated_at'],
      email: map['email'],
      email_verified: map['email_verified'],
      iss: map['iss'],
      sub: map['sub'],
      aud: map['aud'],
      iat: map['iat']?.toInt(),
      exp: map['exp']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(nickname: $nickname, name: $name)';
  }
}
