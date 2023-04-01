import 'package:equatable/equatable.dart';
import 'package:taskom/config/constants/constants.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [];

  factory Failure.connectionFailure() =>
      const Failure(Constants.CONNECTION_ERROR_MESSAGE);

  factory Failure.serverFailure(String? message) =>
      Failure(message ?? Constants.NONE_TEXTUAL_ERROR_MESSAGE);
}

class AuthFailure extends Failure {
  final Map<String, dynamic>? error;
  const AuthFailure({required String message, this.error}) : super(message);

  @override
  List<Object?> get props => [];
}
