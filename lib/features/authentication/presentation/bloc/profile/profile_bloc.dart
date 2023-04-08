import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/domain/usecase/get_all_avatars.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_event.dart';
import 'package:taskom/features/authentication/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllAvatars _getAllAvatars = locator.get();

  ProfileBloc() : super(ProfileInitState()) {
    on<AvatarListRequestEvent>(
      (event, emit) async {
        emit(ProfileLoadingState());
        var avatarList = await _getAllAvatars.call(null);
        emit(AllAvatarsResponseState(avatarList));
      },
    );
  }
}
