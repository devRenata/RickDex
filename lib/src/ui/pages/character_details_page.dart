import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/ui/themes/app_colors.dart';
import 'package:rick/src/ui/viewmodels/favorites_viewmodel.dart';

class CharacterDetailsPage extends StatefulWidget {
  final Character character;

  const CharacterDetailsPage({
    super.key,
    required this.character,
  });

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    _setSystemColors();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textBlack,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              top: 10,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Consumer<FavoritesViewmodel>(
                builder: (context, viewmodel, child) {
                  final currentCharacter = widget.character;
                  final isFavorite = viewmodel.isFavorite(currentCharacter);
                  return IconButton(
                    onPressed: () {
                      if (isFavorite) {
                        viewmodel.removeFavorite(character: currentCharacter);
                      } else {
                        viewmodel.addFavorite(character: currentCharacter);
                      }
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite ? AppColors.primary : AppColors.textBlack,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: size.width,
            width: double.infinity,
            color: AppColors.primary,
            child: Image.network(
              widget.character.image,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.6,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.backgroundGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 60,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          widget.character.name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Status',
                        info: widget.character.status.name,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Species',
                        info: widget.character.species,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Type',
                        info: widget.character.type,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Gender',
                        info: widget.character.gender,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Origin',
                        info: widget.character.origin,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Last Location',
                        info: widget.character.location,
                      ),
                      const SizedBox(height: 16),
                      _buildCharacterItem(
                        icon: Icons.male,
                        title: 'Created In',
                        info: widget.character.created.toString().split(' ').first,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterItem({
    required IconData icon,
    required String title,
    required String info,
  }) {
    final size = MediaQuery.of(context).size;
    final formattedInfo = info
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.width * 0.12,
          height: size.width * 0.12,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getItemIcon(title, info),
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGray,
              ),
            ),
            Text(
              formattedInfo.isEmpty ? 'Unknown' : formattedInfo,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getItemIcon(String title, String info) {
    final Map<String, IconData> titleIcons = {
      'status': Icons.favorite_rounded,
      'species': Icons.pets,
      'type': Icons.pest_control_rounded,
      'origin': Icons.public,
      'last location': Icons.location_on_rounded,
      'created in': Icons.create_rounded,
    };

    final Map<String, IconData> genderIcons = {
      'male': Icons.male,
      'female': Icons.female,
    };

    final key = title.toLowerCase();
    if (key == 'gender') {
      return genderIcons[info.toLowerCase()] ?? Icons.question_mark_rounded;
    }

    return titleIcons[key] ?? Icons.circle;
  }

  Future<void> _setSystemColors() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.backgroundGray,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }
}
