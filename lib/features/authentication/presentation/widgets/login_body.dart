import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_state.dart';
import 'package:taskom/features/authentication/presentation/widgets/form_bottom_text.dart';
import 'package:taskom/features/authentication/presentation/widgets/login_textfields.dart';

class LoginBody extends StatefulWidget {
  final String? avatarId;

  const LoginBody({
    super.key,
    this.avatarId,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  void initState() {
    _getAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 58,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AvatarResponseState) {
                  return state.avatar.fold(
                    (failure) => Text(failure.message),
                    (response) {
                      return SizedBox(
                        width: 162,
                        child: CachedImage(imageUrl: response.welcome),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const Text(
              "ورود به حساب کاربری",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const LoginTextFields(),
            const SizedBox(
              height: 42,
            ),
            AppButton(
              text: "ورود",
              onPressed: () {},
            ),
            const SizedBox(
              height: 12,
            ),
            FormBottomText(
              firstText: "حساب کاربری ندارید؟",
              secondText: "ثبت نام کنید",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteNames.register,
                  arguments: widget.avatarId,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _getAvatar() {
    BlocProvider.of<ProfileBloc>(context).add(
      AvatarRequestEvent(id: widget.avatarId!),
    );
  }
}
