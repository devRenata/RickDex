// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      id: fields[0] as int,
      name: fields[1] as String,
      status: fields[2] as CharacterStatus,
      species: fields[3] as String,
      type: fields[4] as String,
      gender: fields[5] as String,
      origin: fields[6] as String,
      location: fields[7] as String,
      image: fields[8] as String,
      created: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.origin)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharacterStatusAdapter extends TypeAdapter<CharacterStatus> {
  @override
  final int typeId = 1;

  @override
  CharacterStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CharacterStatus.alive;
      case 1:
        return CharacterStatus.dead;
      case 2:
        return CharacterStatus.genderless;
      case 3:
        return CharacterStatus.unknown;
      default:
        return CharacterStatus.alive;
    }
  }

  @override
  void write(BinaryWriter writer, CharacterStatus obj) {
    switch (obj) {
      case CharacterStatus.alive:
        writer.writeByte(0);
        break;
      case CharacterStatus.dead:
        writer.writeByte(1);
        break;
      case CharacterStatus.genderless:
        writer.writeByte(2);
        break;
      case CharacterStatus.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
