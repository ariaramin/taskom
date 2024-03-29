import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/core/util/failure.dart';
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

  AllAvatarsResponseState(this.avatarList);

  @override
  List<Object?> get props => [];
}
