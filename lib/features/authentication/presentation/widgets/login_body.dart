import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/authentication/presentation/widgets/form_bottom_text.dart';
import 'package:taskom/features/authentication/presentation/widgets/login_textfields.dart';

class LoginBody extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 52,
            ),
            const Text(
              "ورود به حساب کاربری",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            LoginTextFields(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(
              height: 32,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (AuthManager.isLogedIn()) {
                  await Future.delayed(const Duration(milliseconds: 500), () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouteNames.base,
                      (route) => false,
                    );
                  });
                }
              },
              builder: (context, state) {
                return AppButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginRequest(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  isLoading: state is AuthLoadingState ? true : false,
                  text: "ورود",
                );
              },
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
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
