import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttersqflitesample/database/database_helper.dart';
import 'package:fluttersqflitesample/model/student.dart';
import 'package:fluttersqflitesample/screen/login_page.dart';
import 'package:fluttersqflitesample/screen/student_list.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = new GlobalKey<FormState>();
  DatabaseHelper helper = DatabaseHelper();
  Student student;
  String _name;
  String _department;
  String _rollNo;
  String _password;
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Student Registration",
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
                        RaisedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: new Text(
                              "Signup",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          color: Colors.blue,
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

  void _submit() async{
    final form = formKey.currentState;
    if(form.validate()){
      _name = nameController.text;
      _department = departmentController.text;
      _rollNo = rollNoController.text;
      _password = passwordController.text;
      Student student = Student(_name, _department, _rollNo, _password);
      int result = await helper.insertStudent(student);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentList()));
    }
  }

  // Update the name of Student object
  void updateName(){
    student.name = nameController.text;
  }

  // Update the department of Student object
  void updateDepartment(){
    student.department = departmentController.text;
  }

  // Update the roll no of Student object
  void updateRollNo(){
    student.rollNo = rollNoController.text;
  }

  // Update the password of Student object
  void updatePassword(){
    student.password = passwordController.text;
  }
}
