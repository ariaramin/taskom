import 'package:flutter/material.dart';
import 'package:taskom/features/settings/data/models/settings_item.dart';
import 'package:taskom/features/settings/presentation/widgets/avatar_container.dart';
import 'package:taskom/features/settings/presentation/widgets/settings_list.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AvatarContainer(),
        ),
        SettingsList(
          settingsList: SettingsItem.getSettingsItems(),
        ),
      ],
    );
  }
}
