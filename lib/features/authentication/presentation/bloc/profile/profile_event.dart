import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class AvatarListRequestEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
