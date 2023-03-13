import 'package:flutter/material.dart';
import 'package:taskom/config/theme/app_colors.dart';

class TimeLineTabBar extends StatelessWidget {
  // final DateTime startTime;
  // final DateTime endTime;
  final Function(List<DateTime>? times) onSelectedTimeChange;

  const TimeLineTabBar({
    Key? key,
    // required this.endTime,
    // required this.startTime,
    required this.onSelectedTimeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _getTimeLineItem().length,
      child: Stack(
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
            onTap: (index) {
              index == 0
                  ? onSelectedTimeChange(null)
                  : onSelectedTimeChange(_getPairedTimeList()[index - 1]);
            },
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
            tabs: _getTimeLineItem(),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTimeLineItem() {
    List<Widget> tabList = [
      const Tab(
        text: "همه",
      )
    ];
    for (var time in _getPairedTimeList()) {
      tabList.add(
        Tab(
          text: "${_setTabText(time[0])} - ${_setTabText(time[1])}",
        ),
      );
    }
    return tabList;
  }

  _setTabText(DateTime dateTime) {
    var hour = dateTime.hour == 0 ? "0${dateTime.hour}" : dateTime.hour;
    return dateTime.minute != 0 ? "$hour:${dateTime.minute}" : hour;
  }

  List<List<DateTime>> _getPairedTimeList() {
    List<List<DateTime>> pairedList = [];
    for (var i = 0; i < _getTimeList().length; i++) {
      pairedList.add(
          [_getTimeList()[i], _getTimeList()[(i + 1) % _getTimeList().length]]);
    }
    pairedList.removeLast();
    return pairedList;
  }

  List<DateTime> _getTimeList() {
    List<DateTime> timeList = [];
    var today = DateTime.now();
    var startTime = DateTime(today.year, today.month, today.day, 7, 30);
    var endTime = startTime.add(const Duration(hours: 16));
    var totalMin = endTime.difference(startTime).inHours;
    for (var i = 0; i <= totalMin; i++) {
      timeList.add(startTime.add(Duration(minutes: (i * 90))));
    }
    return timeList;
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
