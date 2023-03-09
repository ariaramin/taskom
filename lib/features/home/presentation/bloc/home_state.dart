import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/features/task/data/models/category.dart';
import 'package:taskom/features/task/data/util/failure.dart';

abstract class HomeState extends Equatable {}

class HomeInitState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeResponseState extends HomeState {
  final Either<Failure, List<Category>> allCategories;

  HomeResponseState({required this.allCategories});

  @override
  List<Object?> get props => [];
}
