import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick/src/ui/themes/app_assets.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

class BuildMenuDrawer extends StatelessWidget {
  const BuildMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentRoute = GoRouterState.of(context).name;

    return Drawer(
      backgroundColor: AppColors.backgroundGray,
      width: size.width * 0.65,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Center(
            child: Image.asset(
              width: size.width * 0.5,
              fit: BoxFit.cover,
              AppAssets.logo,
            ),
          ),
          SizedBox(height: size.height * 0.08),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  isSelected: currentRoute == 'characters',
                  icon: Icons.group,
                  title: "Characters",
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'characters') {
                      context.go('/characters');
                    }
                  },
                ),
                _buildMenuItem(
                  isSelected: currentRoute == 'favorites',
                  icon: Icons.favorite_rounded,
                  title: "Favorites",
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != 'favorites') {
                      context.go('/favorites');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildMenuItem({
    required bool isSelected,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      tileColor: isSelected ? AppColors.primary.withAlpha(30) : Colors.white,
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.lightGray,
      ),
      trailing: Icon(
        isSelected
            ? Icons.arrow_back_ios_rounded
            : Icons.arrow_forward_ios_rounded,
        color: isSelected ? AppColors.primary : AppColors.lightGray,
        size: 18,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
