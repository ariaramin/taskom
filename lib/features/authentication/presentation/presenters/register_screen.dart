import 'package:flutter/material.dart';
import 'package:taskom/features/authentication/presentation/widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RegisterBody(),
      ),
    );
  }
}
