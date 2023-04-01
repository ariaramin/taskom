import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_state.dart';
import 'package:taskom/features/authentication/presentation/widgets/form_bottom_text.dart';
import 'package:taskom/features/authentication/presentation/widgets/register_textfields.dart';

class RegisterBody extends StatefulWidget {
  final String? avatarId;

  const RegisterBody({
    super.key,
    this.avatarId,
  });

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Avatar avatar;

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
                      avatar = response;
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
              "ساخت حساب کاربری",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            RegisterTextFields(
              usernameController: _usernameController,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(
              height: 42,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AppButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterRequest(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        avatar: avatar,
                      ),
                    );
                    // if (state is AuthResponseState) {
                    //   Navigator.pushNamedAndRemoveUntil(
                    //     context,
                    //     AppRouteNames.base,
                    //     (route) => false,
                    //   );
                    // }
                  },
                  isLoading: state is AuthLoadingState ? true : false,
                  text: "ثبت نام",
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            FormBottomText(
              firstText: "حساب کاربری دارید؟",
              secondText: "وارد شوید",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteNames.login,
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
