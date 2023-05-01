import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/filter.dart';

class TaskListParams extends Params {
  final Filter filter;

  TaskListParams({required this.filter});

  @override
  List<Object?> get props => [];
}
