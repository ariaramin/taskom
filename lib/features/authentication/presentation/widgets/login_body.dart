import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/features/authentication/presentation/widgets/form_bottom_text.dart';
import 'package:taskom/features/authentication/presentation/widgets/login_textfields.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

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
            SizedBox(
              width: 128,
              child: Image.asset("assets/images/avatar.png"),
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
            const FormBottomText(
              firstText: "حساب کاربری ندارید؟",
              secondText: "ثبت نام کنید",
            ),
          ],
        ),
      ),
    );
  }
}
