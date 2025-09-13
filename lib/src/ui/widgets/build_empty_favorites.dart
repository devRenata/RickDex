import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

class BuildEmptyFavorites extends StatelessWidget {
  const BuildEmptyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.heart_broken_outlined,
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
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Você não possui nenhum personagem favorito.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textGray,
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: size.height * 0.04,
            child: ElevatedButton(
              onPressed: () {
                context.go('/characters');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1,
                  vertical: 0,
                ),
              ),
              child: const Text('Explorar Personagens'),
            ),
          ),
        ],
      ),
    );
  }
}
