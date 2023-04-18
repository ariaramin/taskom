import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/section_title.dart';
import 'package:taskom/config/constants/assets_manager.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';

class TaskDatetime extends StatelessWidget {
  const TaskDatetime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          const SectionTitle(
            title: "روز و ساعت تسک",
            visibleLeadingText: false,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Row(
              children: [
                AppChip(
                  title: DateTime.now().getJalaliDayAndMonth(),
                  widget: SvgPicture.asset(
                    AssetsManager.calendar,
                    width: 18,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                AppChip(
                  title: "10:30",
                  widget: SvgPicture.asset(
                    AssetsManager.time,
                    width: 18,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
