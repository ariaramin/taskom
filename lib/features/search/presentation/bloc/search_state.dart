import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/task/data/models/task.dart';

abstract class SearchState extends Equatable {}

class SearchInitState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchResponseState extends SearchState {
  final Either<Failure, List<TaskModel>> taskList;

  SearchResponseState({
    required this.taskList,
  });

  @override
  List<Object?> get props => [];
}
