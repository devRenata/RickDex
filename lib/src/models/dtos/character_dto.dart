import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick/src/models/entities/character.dart';

part 'character_dto.g.dart';

@HiveType(typeId: 0)
class CharacterDto {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String origin;

  @HiveField(7)
  final String location;

  @HiveField(8)
  final String image;

  @HiveField(9)
  final DateTime created;

  CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.created,
  });

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: CharacterStatus.values.byName(status),
      species: species,
      type: type,
      gender: gender,
      origin: origin,
      location: location,
      image: image,
      created: created,
    );
  }

  factory CharacterDto.fromEntity(Character character) {
    return CharacterDto(
      id: character.id,
      name: character.name,
      status: character.status.name,
      species: character.species,
      type: character.type,
      gender: character.gender,
      origin: character.origin,
      location: character.location,
      image: character.image,
      created: character.created,
    );
  }
}
