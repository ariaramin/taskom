import 'package:equatable/equatable.dart';

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
  final String fullName, email, password;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}
