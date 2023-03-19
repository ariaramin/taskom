import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_textfield.dart';
import 'package:taskom/config/constants/assets_manager.dart';

class LoginTextFields extends StatelessWidget {
  const LoginTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: AppTextField(
            labelText: "نام کاربری",
            iconUrl: AssetsManager.user,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: AppTextField(
            labelText: "رمز عبور",
            iconUrl: AssetsManager.key,
            isPassword: true,
          ),
        ),
      ],
    );
  }
}
