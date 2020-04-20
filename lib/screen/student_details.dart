import 'package:flutter/material.dart';
import 'package:fluttersqflitesample/database/database_helper.dart';
import 'package:fluttersqflitesample/model/student.dart';

class StudentDetails extends StatefulWidget {
  final Student student;
  StudentDetails({this.student});

  @override
  _StudentDetailsState createState() => _StudentDetailsState(this.student);
}

class _StudentDetailsState extends State<StudentDetails> {
  final formKey = new GlobalKey<FormState>();
  Student student;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _StudentDetailsState(this.student);
  @override
  Widget build(BuildContext context) {
    nameController.text = student.name;
    departmentController.text = student.department;
    rollNoController.text = student.rollNo;
    passwordController.text = student.password;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Student Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: inputField(nameController,"Name","Please enter name.")
                        ),
                        new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: inputField(departmentController, "Department", "Please enter department.")
                        ),
                        new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: inputField(rollNoController, "Roll No", "Please enter roll no.")
                        ),
                        new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: inputField(passwordController, "Password", "Please enter password")
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                               setState(() {
                                 _save();
                               });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: new Text(
                                  "Save",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            RaisedButton(
                              onPressed: () {
                               setState(() {
                                 _delete();
                               });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: new Text(
                                  "Delete",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, String labelText, String errorMsg){
    return TextFormField(
      controller: controller,
      validator: (String value) {
        if(value.isEmpty) {
          return errorMsg;
        }
      },
      decoration: new InputDecoration(labelText: labelText),
    );
  }

  // Save data to database
  void _save() async{
    Navigator.pop(context,true);
    student.name = nameController.text;
    student.department = departmentController.text;
    student.rollNo = rollNoController.text;
    student.password = passwordController.text;

    // Update Operation
    int result = await helper.updateStudent(student);

    if(result != 0){ // Success
      _showAlertDialog('Status','Student Saved Successfully');
    } else { // Failure
      _showAlertDialog('Status','Problem Saving Student');
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }

  // Delete data from database
  void _delete() async{
    Navigator.pop(context,true);
    int result = await helper.deleteStudent(student.id);
    if (result != 0){
      _showAlertDialog('Status', 'Student Deleted successfully');
    } else{
      _showAlertDialog('Status', 'Error Occured While Deleting Student');
    }
  }
}
