import 'dart:io';

import 'package:navigation_app/model/students.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._();

  static late Database _database;

  final String _tableName = 'STUDENTS';
  final String _columnID = 'ID';
  final String _columnName = 'NAME';

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Students.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_tableName ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnName TEXT)',
    );
  }

  // INSERT
  Future<Student> insertStudent(Student student) async {
    Database db = await database;
    student.id = await db.insert(
      _tableName,
      student.toMap(),
    );

    return student;
  }

  // UPDATE
  Future<int> updateStudent(Student student) async {
    Database db = await database;

    int count = await db.update(_tableName, student.toMap(),
        where: '$_columnID = ?', whereArgs: [student.id]);
    return count;
  }

  //QUERY
  Future<List<Student>> getStudents() async {
    Database db = await database;

    List<Map<String, dynamic>> studentMapList = await db.query(_tableName);

    List<Student> studentsList = [];
    for (var element in studentMapList) {
      studentsList.add(Student.fromMap(element));
    }

    return studentsList;
  }

  //DELETE
  Future<int> deleteStudent(Student student) async {
    Database db = await database;

    int count = await db
        .delete(_tableName, where: '$_columnID = ?', whereArgs: [student.id]);
    return count;
  }
}
