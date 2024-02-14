import 'package:book_app/Components/dialog_box.dart';
import 'package:book_app/Components/info_tile.dart';
import 'package:book_app/manageData/database.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ManagePage extends StatefulWidget {
  const  ManagePage({super.key,});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {

  //ref hive box
  final _myBox = Hive.box('myBox');
  //instsance of local database
  DataBase db= DataBase();

  @override
  void initState() {
    //for first time opening app => create default data
    if( _myBox.get("USERLIST") == null ){
      db.createInitialData();
    }else{
      //already exists data
      db.loadData();
    }

    super.initState();
  }

  //text controllers
  final _bookController = TextEditingController();
  final _nameController = TextEditingController();

  //list of book, user and isReturned
  // List userList= [
  //   ["Book Name","User Name",false],
  //   ["Book Name","User Name",false],
  // ];

  //check if Checkbox is tapped
  void checkBoxChanged (bool? value, int index) {
    setState(() {
      db.userList[index][2] = !db.userList[index][2];
    });
    db.updateData();
  }

  //save new box in ManagePage
  void saveNewBox () {
    setState(() {
      db.userList.add([ _bookController.text, _nameController.text, false ]);
      _bookController.clear();
      _nameController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  //create a new BOX
  void createNewBox () {
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          bookController: _bookController,
          nameController: _nameController,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewBox,
        );
      }
    );
  }

  //delete a BOX
  void deleteBox (int index) {
    setState(() {
      db.userList.removeAt(index);
    });
    db.updateData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Manage Books"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewBox,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.userList.length,
        itemBuilder: ((context, index) {
          return InfoTile(
            bookName: db.userList[index][0],
            userName: db.userList[index][1],
            isReturned: db.userList[index][2],
            onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: () => deleteBox(index),
          );
        }),
      ),
    );
  }
}