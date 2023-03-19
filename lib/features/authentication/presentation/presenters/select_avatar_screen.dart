import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/widgets/select_avatar_body.dart';

class SelectAvatarScreen extends StatelessWidget {
  const SelectAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: const SelectAvatarBody(),
      ),
    );
  }
}
