// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PessoaAdapter extends TypeAdapter<Pessoa> {
  @override
  final int typeId = 1;

  @override
  Pessoa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pessoa(
      fields[1] as String,
      fields[2] as double,
      fields[3] as double,
      fields[4] as double,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pessoa obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._nome)
      ..writeByte(2)
      ..write(obj._altura)
      ..writeByte(3)
      ..write(obj._peso)
      ..writeByte(4)
      ..write(obj._imc)
      ..writeByte(5)
      ..write(obj._resultado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PessoaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
