import 'package:flutter/material.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

class BuildCharacterStat extends StatelessWidget {
  final String stat;
  final bool enabledIcon;

  const BuildCharacterStat({
    super.key,
    required this.stat,
    this.enabledIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: EdgeInsets.symmetric(
        horizontal: enabledIcon ? 10 : 16,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        stat[0].toUpperCase() + stat.substring(1).toLowerCase(),
        textScaler: TextScaler.noScaling,
        style: const TextStyle(
          color: AppColors.textBlack,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          height: 0.8,
        ),
      ),
    );
  }
}
