import 'package:taskom/features/authentication/data/models/avatar.dart';

abstract class ProfileDatasource {
  Future<List<Avatar>> getAllAvatars();
}
