import 'package:flutter/material.dart';
import 'package:taskom/features/settings/presentation/widgets/app_version_text.dart';
import 'package:taskom/features/settings/presentation/widgets/settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SettingsBody(),
      ),
      bottomNavigationBar: AppVersionText(),
    );
  }
}
