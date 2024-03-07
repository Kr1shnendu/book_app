import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final bookController;
  final nameController;
  VoidCallback onCancel;
  VoidCallback onSave;

  DialogBox({
    super.key,
    required this.bookController,
    required this.nameController,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 220,
        child: Column(
          children: [
            //get book name
            TextField(
              controller: bookController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the book",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //get user name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the Borrower",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //save and cancel button
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                //cancel button
                MaterialButton(
                  onPressed: onCancel,
                  color: Colors.white,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red.shade300),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                //save button
                MaterialButton(
                  onPressed: onSave,
                  color: Colors.white,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.green.shade300),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
