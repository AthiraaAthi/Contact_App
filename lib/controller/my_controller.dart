import 'package:sqflite/sqflite.dart';

class EditingController {
  static late Database database;
  //static function ne name vch call chyam using dot
  List data = [];

  static initializeDb() async {
    //cant write directly so we created a function for initializing the db
    //open the db
    //database database ne late aay set chythu(can also used in future) then called it
    database = await openDatabase("MyDb", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, name2 TEXT, phone TEXT, email TEXT)');
      //primaryKey-unique key
    });
  }

  AddScreen(
      {required String name,
      required String name2,
      required String phone,
      required String email}) async {
    await database.rawInsert(
        'INSERT INTO Student(name, name2, phone, email) VALUES(?, ?, ?, ?)',
        [name, name2, phone, email]);
  }

  getAllData() async {
    data = await database.rawQuery('SELECT * FROM Student');
  }

  EditScreen(
      String name, String name2, String phone, String email, int id) async {
    await database.rawUpdate(
        'UPDATE Student SET name = ?, name2 = ?, phone = ?, email = ? WHERE id = ?',
        [name, name2, phone, email, id]);
  }

  DeleteScreen(int id) async {
    await database.rawDelete('DELETE FROM Student WHERE id = ?', [id]);
  }
}
