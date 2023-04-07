import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
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
  String? _selectedAvatarId;

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
              height: 58,
            ),
            const Text(
              "انتخاب آواتار",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            SizedBox(
              height: 392,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AllAvatarsResponseState) {
                    return state.avatarList
                        .fold((failure) => Text(failure.message), (response) {
                      _setSelectedAvatar(response);
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
                                  _selectedAvatarId = response[index].id;
                                });
                              },
                              child: Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(62),
                                  border: _selectedAvatarIndex == index
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
                                    imageUrl: response[index].main,
                                  ),
                                ),
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
            const SizedBox(
              height: 52,
            ),
            AppButton(
              text: "انتخاب",
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   AppRouteNames.register,
                //   arguments: _selectedAvatarId,
                //   (route) => false,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  _setSelectedAvatar(List<Avatar> response) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedAvatarId = response[_selectedAvatarIndex].id;
    });
  }

  _getData() {
    BlocProvider.of<ProfileBloc>(context).add(AvatarListRequestEvent());
  }
}
