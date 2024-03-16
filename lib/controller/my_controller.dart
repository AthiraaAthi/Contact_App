import 'package:sqflite/sqflite.dart';

class MyController {
  static late Database database;
  List data = [];
  static initializedb() async {
    // open the database
    database = await openDatabase("my db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Person (id INTEGER PRIMARY KEY, name TEXT, name2 TEXT, phone TEXT, email TEXT)');
    });
  }

  Future<void> AddScreen(
      {required String name,
      required String name2,
      required String phone,
      required String email}) async {
    await database.rawInsert(
        'INSERT INTO Person(name, name2, phone, email) VALUES(?, ?, ?, ?)',
        [name, name2, phone, email]);
  }

  Future<void> getAllData() async {
    data = await database.rawQuery('SELECT * FROM Person');
  }

  Future<void> editScreen(String Newname, int id) async {
    await database
        .rawUpdate('UPDATE Person SET name = ? WHERE id = ?', [Newname, id]);
  }

  Future<void> deleteScreen(int id) async {
    await database.rawDelete('DELETE FROM Person WHERE id = ?', [id]);
  }
}
