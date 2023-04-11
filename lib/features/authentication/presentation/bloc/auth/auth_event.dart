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
  final String fullName, email, password;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}

class UpdateUserRequestEvent extends AuthEvent {
  final String id;
  final String? fullName, email, password;
  final Avatar? avatar;

  UpdateUserRequestEvent({
    required this.id,
    this.fullName,
    this.email,
    this.password,
    this.avatar,
  });

  @override
  List<Object?> get props => [];
}

class GetUserRequestEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
