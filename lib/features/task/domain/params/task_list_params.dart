import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/config/util/filter.dart';

class TaskListParams extends Params {
  final Filter filter;

  TaskListParams({required this.filter});

  @override
  List<Object?> get props => [];
}
