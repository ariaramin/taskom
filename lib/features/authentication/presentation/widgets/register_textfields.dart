import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_textfield.dart';

class RegisterTextFields extends StatelessWidget {
  const RegisterTextFields({
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
            iconUrl: "assets/icons/User.svg",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: AppTextField(
            labelText: "ایمیل",
            iconUrl: "assets/icons/Message.svg",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: AppTextField(
            labelText: "رمز عبور",
            iconUrl: "assets/icons/Key.svg",
            isPassword: true,
          ),
        ),
      ],
    );
  }
}
