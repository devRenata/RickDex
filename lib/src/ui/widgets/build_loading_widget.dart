import 'package:flutter/material.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

class BuildLoadingWidget extends StatelessWidget {
  const BuildLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
