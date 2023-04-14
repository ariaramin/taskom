import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserResponseState) {
          return state.response.fold((l) => const SizedBox(), (response) {
            return Padding(
              padding: const EdgeInsets.only(top: 38, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContinuousRectangle(
                    size: 86,
                    radius: 68,
                    backgroundColor: AppColors.secondaryColor,
                    widget: CachedImage(imageUrl: response.avatar),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    response.name!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    response.username!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyColor,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            );
          });
        }
        return const SizedBox();
      },
    );
  }
}
