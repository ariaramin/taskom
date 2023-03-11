import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class TimeLineTabBar extends StatelessWidget {
  // final Function(String? time) onSelectedTimeChange;

  const TimeLineTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Positioned(
          top: 5,
          left: 0,
          right: 0,
          child: Container(
            height: 1,
            color: AppColors.greyColor.withOpacity(.5),
          ),
        ),
        TabBar(
          indicator: CircleTabIndicator(
            color: AppColors.primaryColor,
            radius: 6,
          ),
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return states.contains(MaterialState.focused)
                  ? null
                  : Colors.transparent;
            },
          ),
          isScrollable: true,
          physics: const NeverScrollableScrollPhysics(),
          unselectedLabelColor: AppColors.greyColor,
          labelColor: Theme.of(context).colorScheme.onBackground,
          labelStyle: const TextStyle(
            fontFamily: "Shabnam",
            fontSize: 14,
          ),
          padding: const EdgeInsets.only(top: 6),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          tabs: const [
            Tab(text: 'همه'),
            Tab(text: '۱۰ - ۸:۳۰'),
            Tab(text: '۱۱:۳۰ - ۱۰'),
            Tab(text: '۱ - ۱۱:۳۰'),
            Tab(text: '۲:۳۰ - ۱'),
            Tab(text: '۴ - ۲:۳۰'),
            Tab(text: '۵:۳۰ - ۴'),
            Tab(text: '۷ - ۵:۳۰'),
          ],
        ),
      ],
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(cfg.size!.width / 2, 0);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
