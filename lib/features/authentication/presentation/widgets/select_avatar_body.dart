import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_state.dart';

class SelectAvatarBody extends StatefulWidget {
  const SelectAvatarBody({
    super.key,
  });

  @override
  State<SelectAvatarBody> createState() => _SelectAvatarBodyState();
}

class _SelectAvatarBodyState extends State<SelectAvatarBody> {
  int _selectedAvatarIndex = 0;
  Avatar? _selectedAvatar;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getData();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 52,
            ),
            const Text(
              "انتخاب آواتار",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Flexible(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AllAvatarsResponseState) {
                    return state.avatarList
                        .fold((failure) => Center(child: Text(failure.message)),
                            (response) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                        ),
                        itemCount: response.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAvatarIndex = index;
                                  _selectedAvatar = response[index];
                                });
                              },
                              child: AvatarItem(
                                currentIndex: index,
                                selectedAvatarIndex: _selectedAvatarIndex,
                                imageUrl: response[index].main,
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }
                  return const SizedBox();
                },
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthResponseState) {
                  state.response.fold((l) => null, (r) async {
                    await Future.delayed(
                      const Duration(milliseconds: 500),
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouteNames.base,
                          (route) => false,
                        );
                      },
                    );
                  });
                }
                return AppButton(
                  text: "انتخاب",
                  onPressed: () {
                    var userId = AuthManager.getUserId();
                    BlocProvider.of<AuthBloc>(context)
                        .add(UpdateUserRequestEvent(
                      id: userId,
                      avatar: _selectedAvatar,
                    ));
                  },
                  isLoading: state is AuthLoadingState ? true : false,
                );
              },
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  _getData() {
    BlocProvider.of<ProfileBloc>(context).add(AvatarListRequestEvent());
  }
}

class AvatarItem extends StatelessWidget {
  final int currentIndex;
  final int selectedAvatarIndex;
  final String? imageUrl;

  const AvatarItem({
    super.key,
    required this.currentIndex,
    required this.selectedAvatarIndex,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(62),
        border: selectedAvatarIndex == currentIndex
            ? Border.all(
                width: 4,
                color: AppColors.primaryColor,
              )
            : null,
        color: AppColors.secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: CachedImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
