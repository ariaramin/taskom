import 'package:taskom/features/task/data/models/gallery.dart';

abstract class TaskDetailDatasource {
  Future<List<Gallery>> getGallery();
}
