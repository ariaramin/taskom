import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/components/continuous_rectangle.dart';
import 'package:taskom/config/constants/assets_manager.dart';
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
            return Container(
              margin: const EdgeInsets.all(14),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ContinuousRectangle(
                    size: 68,
                    backgroundColor: AppColors.secondaryColor,
                    widget: CachedImage(imageUrl: response.avatar),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        response.name!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AssetsManager.leftArrow,
                      width: 10,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
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
