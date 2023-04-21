import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/authentication/presentation/widgets/form_bottom_text.dart';
import 'package:taskom/features/authentication/presentation/widgets/register_textfields.dart';

class RegisterBody extends StatelessWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 52,
            ),
            const Text(
              "ساخت حساب کاربری",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            RegisterTextFields(
              fullNameController: _fullNameController,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(
              height: 32,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is AuthResponseState) {
                  state.response.fold((failure) {
                    final snackBar = Constants.getSnackBar(
                      title: Constants.ERROR_MESSAGE,
                      message: failure.message,
                      type: ContentType.failure,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }, (response) {
                    final snackBar = Constants.getSnackBar(
                      title: Constants.SUCCESS_MESSAGE,
                      message: response,
                      type: ContentType.success,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouteNames.selectAvatar,
                      (route) => false,
                    );
                  });
                }
              },
              builder: (context, state) {
                return AppButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterRequest(
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
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
