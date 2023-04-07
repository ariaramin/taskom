import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/domain/usecase/login.dart';
import 'package:taskom/features/authentication/domain/usecase/register.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login = locator.get();
  final Register _register = locator.get();

  AuthBloc() : super(AuthInitState()) {
    on<LoginRequest>(
      (event, emit) async {
        emit(AuthLoadingState());
        var params = LoginParams(
          email: event.email,
          password: event.password,
        );
        var response = await _login.call(params);
        emit(AuthResponseState(response));
      },
    );

    on<RegisterRequest>(
      (event, emit) async {
        emit(AuthLoadingState());
        var params = RegisterParams(
          username: event.fullName,
          email: event.email,
          password: event.password,
        );
        var response = await _register.call(params);
        emit(AuthResponseState(response));
      },
    );
  }
}
