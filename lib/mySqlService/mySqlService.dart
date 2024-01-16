import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MysqlService {
  Database? db;

  Future<Database?> openDataBase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "todoListDb.db");
    db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await createDatabaseTable(db, version);
    });
    return db;
  }

  Future<void> createDatabaseTable(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todoList(userId INTEGER, id INTEGER , title TEXT, completed TEXT)');
  }

  Future<void> insertData(List<Map<String, dynamic>> data) async {
    try {
      for (var todoList in data) await db!.insert('todoList', todoList);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData(Map<String, dynamic> data, int id, int userId) async {
    await db!.update('todoList', data, where: 'id = $id');
  }
}
