import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  isCompleted INTEGER NOT NULL
)
''');
    await db.insert('tasks', {'title': 'Làm bài tập Flutter', 'description': 'Hoàn thành trước thứ Sáu', 'isCompleted': 0});
    await db.insert('tasks', {'title': 'Ôn tập Riverpod', 'description': 'Xem lại bài giảng MVVM', 'isCompleted': 0});
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await instance.database;
    final maps = await db.query('tasks');
    return maps.map((json) => TaskModel.fromMap(json)).toList();
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await instance.database;
    return db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}