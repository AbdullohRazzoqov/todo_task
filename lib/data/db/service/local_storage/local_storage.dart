import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_task/core/utils/constants.dart';
import 'package:todo_task/data/db/model/event_model.dart';


class LocalStorage {
  static final LocalStorage instance = LocalStorage._init();
  static Database? _database;

  factory LocalStorage() => instance;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("events.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const String textType = "TEXT NOT NULL";
    const String intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE $eventTable (
    ${Fields.id} $idType,
    ${Fields.name} $textType,
    ${Fields.description} $textType,
    ${Fields.firstDate} $textType,
    ${Fields.secondDate} $textType,
    ${Fields.day} $textType,
    ${Fields.color} $intType,
    ${Fields.location} $textType
    )
    ''');
  }

  LocalStorage._init();

  //-------------------------------------------Event Table------------------------------------

  static Future<Event> insertEvent(Event event) async {
    final db = await instance.database;
    final id = await db.insert(eventTable, event.toJson());
    return event.copyWith(id: id);
  }

  static Future<Event> getEventById(int id) async {
    final db = await instance.database;
    final results = await db.query(
      eventTable,
      columns: Fields.values,
      where: '${Fields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return Event.fromJson(results.first);
    } else {
      throw 'ID $id not found';
    }
  }

  static Future<List<Event>> getAllEvents({String? date}) async {
    final db = await instance.database;
    if (date != null) {
      const orderBy = "${Fields.id} DESC";
      final result = await db.query(
        eventTable,
        orderBy: orderBy,
        where: '${Fields.day} = ?',
        whereArgs: [date],
      );

      return result.map((json) => Event.fromJson(json)).toList();
    } else {
      const orderBy = "${Fields.id} DESC";
      final result = await db.query(
        eventTable,
        orderBy: orderBy,
      );

      return result.map((json) => Event.fromJson(json)).toList();
    }
  }

  static Future<int> editEvent(Event event, int id) async {
    try {
      final db = await instance.database;
      return await db.update(
        eventTable,
        event.toJson(),
        where: '_id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<int> deleteEventById(int id) async {
    final db = await instance.database;
    var t =
        await db.delete(eventTable, where: "${Fields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> deleteAllEvents() async {
    final db = await instance.database;
    return await db.delete(eventTable);
  }
}
