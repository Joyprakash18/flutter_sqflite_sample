import 'package:flutter/material.dart';
import 'package:fluttersqflitesample/database/database_helper.dart';
import 'package:fluttersqflitesample/screen/registration_page.dart';
import 'package:fluttersqflitesample/screen/student_list.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  String _name;
  String _password;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
//    final Future<Database> db = databaseHelper.initializeDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Student Login",
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
                          child: new TextFormField(
                            controller: nameController,
                            validator: (String value) {
                              if(value.isEmpty) {
                                return "Please Enter Name";
                              }
                            },
                            decoration: new InputDecoration(labelText: "Name"),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new TextFormField(
                            controller: passwordController,
                            validator: (String value) {
                              if(value.isEmpty) {
                                return "Please Enter Password";
                              }
                            },
                            decoration: new InputDecoration(labelText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                _submit();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: new Text(
                                  "Login",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              color: Colors.blue,
                            ),
                            FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                              },
                              child: Text("Signup",style: TextStyle(color: Colors.blue),),
                            )
                          ],
                        )
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


  void _submit() async{
    final form = formKey.currentState;
    if(form.validate()){
      _name = nameController.text;
      _password = passwordController.text;
      int result = await databaseHelper.checkStudent(_name,_password);
      if (result == 1) {
//        _showSnackBar(context, "Login Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentList()),
        );
      } else {
//        _showSnackBar(context, "No Records Found");
      }
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
