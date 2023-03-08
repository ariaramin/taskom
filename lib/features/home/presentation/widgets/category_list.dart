import 'package:flutter/material.dart';
import 'package:taskom/features/home/presentation/widgets/category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 38,
            ),
            child: CategoryItem(),
          );
        },
      ),
    );
  }
}
