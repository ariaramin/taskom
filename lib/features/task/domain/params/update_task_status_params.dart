import 'package:taskom/config/usecase/usecase.dart';

class UpdateTaskStatusParams extends Params {
  final String id;
  final bool status;

  UpdateTaskStatusParams({required this.id, required this.status});

  @override
  List<Object?> get props => [];
}
