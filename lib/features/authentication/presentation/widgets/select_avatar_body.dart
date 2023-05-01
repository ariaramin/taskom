import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/core/components/app_button.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/auth/auth_state.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_bloc.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_state.dart';
import 'package:taskom/features/authentication/presentation/widgets/avatar_item.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "انتخاب آواتار",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 428,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is AllAvatarsResponseState) {
                    return state.avatarList
                        .fold((failure) => Center(child: Text(failure.message)),
                            (response) {
                      _setAvatar(response);
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
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthResponseState) {
                  state.response.fold((failure) {
                    final snackBar = Constants.getSnackBar(
                      title: Constants.ERROR_MESSAGE,
                      message: failure.message,
                      type: ContentType.failure,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }, (response) {
                    final snackBar = Constants.getSnackBar(
                      title: Constants.SUCCESS_MESSAGE,
                      message: response,
                      type: ContentType.success,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  });
                }
              },
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

  _setAvatar(List<Avatar> response) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedAvatar = response[_selectedAvatarIndex];
    });
  }

  _getData() {
    BlocProvider.of<ProfileBloc>(context).add(AvatarListRequestEvent());
  }
}
