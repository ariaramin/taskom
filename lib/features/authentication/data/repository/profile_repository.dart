import 'package:dartz/dartz.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<Avatar>>> getAllAvatars();
}
