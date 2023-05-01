import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/category/data/models/category.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitState extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryListResponse extends CategoryState {
  final Either<Failure, List<Category>> categoryList;

  CategoryListResponse({
    required this.categoryList,
  });

  @override
  List<Object?> get props => [];
}
