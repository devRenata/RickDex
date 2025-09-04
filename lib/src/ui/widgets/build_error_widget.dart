import 'package:flutter/material.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

class BuildErrorWidget extends StatelessWidget {
  final AppException exception;
  final VoidCallback onRetry;

  const BuildErrorWidget({
    super.key,
    required this.exception,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: size.width * 0.14,
            color: AppColors.primary,
          ),
          const SizedBox(height: 20),
          const Text(
            'Opps!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            exception.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textGray,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: size.height * 0.04,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1,
                  vertical: 0,
                ),
              ),
              child: const Text('Tentar Novamente'),
            ),
          ),
        ],
      ),
    );
  }
}
