import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_textfield.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';

class RegisterTextFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterTextFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: AppTextField(
                controller: usernameController,
                labelText: "نام کاربری",
                iconUrl: AssetsManager.user,
                errorText: _getFieldError(state, usernameController, "name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: AppTextField(
                controller: emailController,
                labelText: "ایمیل",
                iconUrl: AssetsManager.message,
                errorText: _getFieldError(state, emailController, "email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: AppTextField(
                controller: passwordController,
                labelText: "رمز عبور",
                iconUrl: AssetsManager.key,
                isPassword: true,
                errorText:
                    _getFieldError(state, passwordController, "password"),
              ),
            ),
            state is AuthResponseState
                ? state.response.fold(
                    (failure) => Text(
                      failure.message,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    (message) => Text(
                      message,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  String? _getFieldError(
    AuthState state,
    TextEditingController controller,
    String field,
  ) {
    if (state is AuthResponseState) {
      return state.response.fold((failure) {
        var authFailure = failure as AuthFailure;
        if (controller.text.isEmpty) {
          return Constants.BLANK_ERROR_MESSAGE;
        }
        return authFailure.error?[field] != null
            ? authFailure.error![field]["message"]
            : null;
      }, (r) => null);
    }
    return null;
  }
}
