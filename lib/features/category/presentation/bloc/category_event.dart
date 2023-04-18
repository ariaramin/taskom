import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class CategoryListRequestEvent extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
