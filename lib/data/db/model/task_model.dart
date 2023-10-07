import 'package:hive_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? location;

  @HiveField(3)
  String? date;

  @HiveField(4)
  int color;

  @HiveField(5)
  DateTime dateTime;

  Task({
    required this.taskName,
    this.description,
    this.location,
    this.date,
    required this.color,
    required this.dateTime,
  });
}

