import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/constants/assets_manager.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: const Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: HomeBody(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            child: SvgPicture.asset(
              AssetsManager.add,
              width: 22,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRouteNames.task);
            },
          ),
        ),
      ),
    );
  }
}
