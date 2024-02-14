import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  //list of book, user and isReturned
  List userList = [];

  //ref a box
  final _myBox = Hive.box('myBox');

  //first time accessing the userList
  void createInitialData() {
    List userList= [
      ["Book Name1","User Name1",false],
      ["Book Name2","User Name2",false],
    ];
  }

  //load the data from the database
  void loadData() {
    userList = _myBox.get("USERLIST");
  }

  //update the database
  void updateData() {
    _myBox.put("USERLIST", userList);
  }

}