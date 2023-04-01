import 'package:equatable/equatable.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';

abstract class AuthEvent extends Equatable {}

class LoginRequest extends AuthEvent {
  final String email, password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}

class RegisterRequest extends AuthEvent {
  final String username, email, password;
  final Avatar avatar;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
  });

  @override
  List<Object?> get props => [];
}
