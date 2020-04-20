class Student {
  String _name;
  String _department;
  String _rollNo;
  String _password;
  int _id;

  Student(this._name, this._department, this._rollNo,this._password);

  Student.withId(this._id, this._name, this._department, this._rollNo,this._password);

  int get id => _id;
  String get name => _name;
  String get department => _department;
  String get rollNo => _rollNo;
  String get password => _password;

  set name(String newName){
    this._name = newName;
  }

  set department(String newDepartment){
    this._department = newDepartment;
  }

  set rollNo(String newRollNo){
    this._rollNo = newRollNo;
  }

  set password(String newPassword){
    this._password = newPassword;
  }

  // Convert a Student object into a Map object
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(id !=null){
      map['id'] = _id;
    }
    map['name'] = _name;
    map['department'] = _department;
    map['rollNo'] = _rollNo;
    map['password'] = _password;
    return map;
  }

  // Extract a Student object from a Map object
  Student.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._department = map['department'];
    this._rollNo = map['rollNo'];
    this._password = map['password'];
  }

}