import 'dart:io';

import 'package:fluttersqflitesample/model/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper{
  final String studentTable = 'student_table';
  final String colId = 'id';
  final String colName = 'name';
  final String colDepartment = 'department';
  final String colRollNo = 'rollNo';
  final String colPassword = 'password';

  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database
  DatabaseHelper._createInstance();// Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is execute only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    // Get the directory path for both Android and ios to store database.
    Directory directory =await getApplicationDocumentsDirectory();
    String path = directory.path + 'student.db';

    // Open/Create the database at a given path
    var studentDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return studentDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $studentTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDepartment TEXT, $colRollNo TEXT, $colPassword TEXT)');
  }

  // Fetch Operation: Get all student objects from database
  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database db = await this.database;
    var result = await db.query(studentTable);
    return result;
  }

  //Insert Operation: Insert a Student object to database
  Future<int> insertStudent(Student student) async {
    Database db = await this.database;
    var result = await db.insert(studentTable, student.toMap());
    return result;
  }

  // Update Operation: Update a Student object and save it to database
  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    var result = await db.update(studentTable, student.toMap(), where: '$colId = ?', whereArgs: [student.id]);
    return result;
  }

  // Delete Operation: Delete a Student object from database
  Future<int> deleteStudent(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $studentTable WHERE $colId = $id');
    return result;
  }

  // Get number of Student objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String,dynamic>> l = await db.rawQuery('SELECT COUNT (*) FROM $studentTable');
    int result = Sqflite.firstIntValue(l);
    return result;
  }

  // To Check Student exist or not
  Future<int> checkStudent(String name,String password) async {
    var db = await this.database;
    List<Map> result = await db.query(studentTable,columns: [colId], where: colName + " = ?" + " AND " + colPassword + " = ?",whereArgs: [name,password]);
    if(result.length>0){
      return 1;
    }
    return 0;
  }

  //Get the 'Map List' [List<Map>] and convert it to 'Student List' [List<Student>]
  Future<List<Student>> getStudentList() async {

    var studentMapList = await getStudentMapList(); // Get 'Map List' from database
    int count = studentMapList.length;

    List<Student> studentList = List<Student>();
    // For loop to create a 'Student List' from a 'Map List'
    for(int i = 0;i<count;i++){
      studentList.add(Student.fromMapObject(studentMapList[i]));
    }
    return studentList;
  }
}