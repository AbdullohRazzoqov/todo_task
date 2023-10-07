// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';


// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 1;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      taskName: fields[0] as String,
      description: fields[1] as String?,
      location: fields[2] as String?,
      date: fields[3] as String?,
      color: fields[4] as int,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
