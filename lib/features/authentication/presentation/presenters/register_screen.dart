import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
          ],
          child: RegisterBody(),
        ),
      ),
    );
  }
}
