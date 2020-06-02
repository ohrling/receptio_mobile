import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String nickname;
  final String name;
  final String picture;
  final String updated_at;
  final String email;
  final bool email_verified;
  final String iss;
  final String sub;
  final String aud;
  final int iat;
  final int exp;

  User({
    this.nickname,
    this.name,
    this.picture,
    this.updated_at,
    this.email,
    this.email_verified,
    this.iss,
    this.sub,
    this.aud,
    this.iat,
    this.exp,
  });
}
