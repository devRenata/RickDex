import 'package:hive_flutter/hive_flutter.dart';

part 'character.g.dart';

@HiveType(typeId: 1)
enum CharacterStatus {
  @HiveField(0)
  alive,

  @HiveField(1)
  dead,

  @HiveField(2)
  genderless,

  @HiveField(3)
  unknown,
}

@HiveType(typeId: 0)
class Character {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final CharacterStatus status;

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

  Character({
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

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'],
      status: CharacterStatus.values.byName(
        (json['status'] as String).toLowerCase(),
      ),
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin']['name'],
      location: json['location']['name'],
      image: json['image'],
      created: DateTime.parse(json['created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'created': created.toIso8601String(),
    };
  }
}
