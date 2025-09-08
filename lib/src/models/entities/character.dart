enum CharacterStatus { alive, dead, genderless, unknown }

class Character {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;
  final String image;
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
