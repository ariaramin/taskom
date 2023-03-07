import 'package:taskom/features/task/data/models/category.dart';
import 'package:taskom/features/task/data/models/gallery.dart';

abstract class TaskDetailDatasource {
  Future<List<Category>> getAllCategories();

  Future<Category> getCategory(String id);

  Future<List<Gallery>> getAllGallery();

  Future<Gallery> getGallery(String id);
}
