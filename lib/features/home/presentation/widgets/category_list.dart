import 'package:flutter/material.dart';
import 'package:taskom/features/home/presentation/widgets/category_item.dart';
import 'package:taskom/features/category/data/models/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categoryList;

  const CategoryList({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 38,
            ),
            child: CategoryItem(
              category: categoryList[index],
            ),
          );
        },
      ),
    );
  }
}
