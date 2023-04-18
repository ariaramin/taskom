import 'package:flutter/material.dart';
import 'package:taskom/config/components/app_textfield.dart';
import 'package:taskom/config/constants/assets_manager.dart';

class TaskFormTextFields extends StatelessWidget {
  const TaskFormTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          AppTextField(
            // controller: emailController,
            labelText: "عنوان",
            iconUrl: AssetsManager.text,
            // errorText: _getFieldError(state, emailController, "email"),
          ),
          const SizedBox(
            height: 24,
          ),
          AppTextField(
            // controller: passwordController,
            labelText: "یادداشت",
            iconUrl: AssetsManager.pin,
            // errorText: _getFieldError(state, passwordController, "password"),
          ),
        ],
      ),
    );
  }
}
