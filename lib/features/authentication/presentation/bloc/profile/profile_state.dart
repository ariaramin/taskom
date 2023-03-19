import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class AllAvatarsResponseState extends ProfileState {
  final Either<Failure, List<Avatar>> avatarList;

  AllAvatarsResponseState({required this.avatarList});

  @override
  List<Object?> get props => [];
}

class AvatarResponseState extends ProfileState {
  final Either<Failure, Avatar> avatar;

  AvatarResponseState({required this.avatar});

  @override
  List<Object?> get props => [];
}
