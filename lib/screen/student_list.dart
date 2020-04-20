import 'package:flutter/material.dart';
import 'package:fluttersqflitesample/database/database_helper.dart';
import 'package:fluttersqflitesample/model/student.dart';
import 'package:fluttersqflitesample/screen/student_details.dart';
import 'package:sqflite/sqflite.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Student> studentList;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    if (studentList == null) {
      studentList = List<Student>();
      updateStudentList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: studentListView(),
    );
  }

  ListView studentListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.verified_user),
            ),
            title: Text(this.studentList[index].name),
            subtitle: Text(this.studentList[index].department),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _delete(context, studentList[index]);
              },
            ),
            onTap: () {
              navigateToDetailsPage(context, index);
            },
          ),
        );
      },
    );
  }

  void navigateToDetailsPage(BuildContext context, int index) async{
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentDetails(student: this.studentList[index],)),
    );
    if (result == true){
      updateStudentList();
    }
  }

  void _delete(BuildContext context, Student student) async {
    int result = await databaseHelper.deleteStudent(student.id);
    if (result != 0) {
      _showSnackBar(context, "Student deleted successfully");
      updateStudentList();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateStudentList() {
    final Future<Database> db = databaseHelper.initializeDatabase();
    db.then((database){
      Future<List<Student>> studentListFuture = databaseHelper.getStudentList();
      studentListFuture.then((studentList){
        setState(() {
          this.studentList = studentList;
          this.count = studentList.length;
        });
      });
    });
  }
}
