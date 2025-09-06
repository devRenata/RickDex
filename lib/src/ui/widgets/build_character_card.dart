import 'package:flutter/material.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/ui/themes/app_colors.dart';
import 'package:rick/src/ui/widgets/build_character_stat.dart';

class BuildCharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onPress;

  const BuildCharacterCard({
    super.key,
    required this.onPress,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: onPress,
            splashColor: Colors.white10,
            highlightColor: Colors.white10,
            child: Stack(
              children: [
                _buildCharacterImage(size),
                _buildCardContent(size),
                _buildCharacterNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterImage(Size size) {
    return Positioned(
      top: 10,
      left: 10,
      bottom: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          character.image,
          height: size.width * 0.2,
          width: size.width * 0.2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCardContent(Size size) {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.2 + 20,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            character.name,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 5,
            children: [
              BuildCharacterStat(stat: character.status),
              BuildCharacterStat(stat: character.species),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterNumber() {
    final number = '#${character.id.toString().padLeft(3, '0')}';
    return Positioned(
      top: 10,
      right: 10,
      child: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.withAlpha(100),
          letterSpacing: 1,
        ),
      ),
    );
  }
}
