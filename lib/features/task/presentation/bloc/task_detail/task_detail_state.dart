import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/task/data/models/gallery.dart';

abstract class TaskDetailState extends Equatable {}

class TaskDetailInitState extends TaskDetailState {
  @override
  List<Object?> get props => [];
}

class TaskDetailLoadingState extends TaskDetailState {
  @override
  List<Object?> get props => [];
}

class TaskImageListResponse extends TaskDetailState {
  final Either<Failure, List<Gallery>> imageList;

  TaskImageListResponse({
    required this.imageList,
  });

  @override
  List<Object?> get props => [];
}
