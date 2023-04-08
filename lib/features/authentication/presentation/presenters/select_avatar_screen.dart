import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/widgets/select_avatar_body.dart';

class SelectAvatarScreen extends StatelessWidget {
  const SelectAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(),
          ),
        ],
        child: const SelectAvatarBody(),
      ),
    );
  }
}
