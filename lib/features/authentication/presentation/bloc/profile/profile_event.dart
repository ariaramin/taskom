import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class AvatarListRequestEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class AvatarRequestEvent extends ProfileEvent {
  final String id;

  AvatarRequestEvent({required this.id});

  @override
  List<Object?> get props => [];
}
