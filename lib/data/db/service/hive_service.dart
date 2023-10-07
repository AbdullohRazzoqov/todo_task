import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/data/db/model/task_model.dart';

class HiveService {
  List<Task?> task = [];
  late Box<Task> taskBox;

  static Future<HiveService> create() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<Task>(
        TaskAdapter(),
      );
    }
    final box = await Hive.openBox<Task>('taskBox');
    return HiveService._create(box);
  }

  HiveService._create(this.taskBox) {
    taskBox = taskBox;
    getTaskAll();
  }

  void addTask(Task task) {
    taskBox.add(task);
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
  }

  void updateTask(int index, Task task) {
    taskBox.putAt(index, task);
  }

  List<Task?> getTaskAll() {
    for (int i = 0; i < taskBox.length; i++) {
      task.add(taskBox.getAt(i));
    }
    return task;
  }
}
