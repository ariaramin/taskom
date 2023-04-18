import 'package:taskom/features/category/data/models/category.dart';

abstract class CategoryDatasource {
  Future<List<Category>> getAllCategories();

  Future<Category> getCategory(String id);
}
