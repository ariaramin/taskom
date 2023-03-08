import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 174,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.pink,
        boxShadow: const [
          BoxShadow(
            color: Colors.pink,
            blurRadius: 25,
            spreadRadius: -12,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -32,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/icons/Education.svg",
              width: 120,
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 16,
            child: Column(
              children: [
                SvgPicture.asset("assets/icons/Education.svg"),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        "آموزش",
                        style: TextStyle(
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
