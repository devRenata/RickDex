import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick/src/ui/themes/app_colors.dart';
import 'package:rick/src/ui/widgets/build_character_card.dart';
import 'package:rick/src/ui/widgets/build_empty_favorites.dart';
import 'package:rick/src/ui/widgets/build_error_widget.dart';
import 'package:rick/src/ui/widgets/build_loading_widget.dart';
import 'package:rick/src/ui/widgets/build_menu_drawer.dart';

import '../viewmodels/favorites_viewmodel.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundGray,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      drawer: const BuildMenuDrawer(),
      body: SafeArea(
        child: Consumer<FavoritesViewmodel>(
          builder: (context, viewmodel, child) {
            if (viewmodel.isLoading && viewmodel.favorites.isEmpty) {
              return const BuildLoadingWidget();
            }

            if (viewmodel.error != null) {
              return BuildErrorWidget(
                exception: viewmodel.error!,
                onRetry: () => viewmodel.getFavorites(),
              );
            }

            if (viewmodel.favorites.isEmpty) {
              return const BuildEmptyFavorites();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: viewmodel.favorites.length,
                    itemBuilder: (context, index) {
                      final character = viewmodel.favorites[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: BuildCharacterCard(
                          onPress: () {
                            context.pushNamed(
                              'character_details',
                              extra: character,
                            );
                          },
                          character: character,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}