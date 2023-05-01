import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/authentication/data/models/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthResponseState extends AuthState {
  final Either<Failure, String> response;
  AuthResponseState(this.response);

  @override
  List<Object?> get props => [];
}

class UserResponseState extends AuthState {
  final Either<Failure, User> response;
  UserResponseState(this.response);

  @override
  List<Object?> get props => [];
}
