import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/components/cached_image.dart';
import 'package:taskom/core/components/continuous_rectangle.dart';
import 'package:taskom/core/extentions/datetime_extention.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/home/presentation/bloc/home_bloc.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.authState is UserResponseState) {
          var authState = state.authState as UserResponseState;
          return authState.response.fold((l) => const SizedBox(), (response) {
            return Row(
              children: [
                ContinuousRectangle(
                  size: 54,
                  backgroundColor: AppColors.secondaryColor,
                  widget: CachedImage(imageUrl: response.avatar),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "سلام، ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          response.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateTime.now().getJalaliDayAndMonth(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        }
        return const SizedBox();
      },
    );
  }
}
