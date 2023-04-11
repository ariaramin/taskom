import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/settings/data/models/settings_item.dart';
import 'package:taskom/features/settings/presentation/widgets/avatar_container.dart';
import 'package:taskom/features/settings/presentation/widgets/settings_list.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({
    super.key,
  });

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  void initState() {
    _getUser();
    super.initState();
  }

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

  _getUser() {
    BlocProvider.of<AuthBloc>(context).add(GetUserRequestEvent());
  }
}
