// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseSchemaAdapter extends TypeAdapter<ExpenseSchema> {
  @override
  final int typeId = 1;

  @override
  ExpenseSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseSchema(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      name: fields[2] as String,
      price: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseSchema obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
