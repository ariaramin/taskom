import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taskom/features/task/data/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 174,
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        color: HexColor(category.color!),
        shadows: [
          BoxShadow(
            color: HexColor(category.color!),
            blurRadius: 25,
            spreadRadius: -12,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -34,
            left: 0,
            right: 0,
            child: SvgPicture.network(
              category.icon!,
              height: 118,
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 16,
            child: Column(
              children: [
                SvgPicture.network(category.icon!),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        category.title!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
