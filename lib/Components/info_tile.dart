import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String bookName;
  final String userName;
  final bool isReturned;
  Function(bool?)onChanged;
  Function()? deleteFunction;

  InfoTile({
    super.key,
    required this.bookName,
    required this.userName,
    required this.isReturned,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 22,),
      child: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              "Book : "+bookName,
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 20,
              ),
            ),
            Text(
              "Borrower : "+userName,
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 15,
              ),
            ),

            Row(
              children: [
                Checkbox(value: isReturned, onChanged: onChanged),
                Text(
                  'returned',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: 120,),
                Text(
                  'delete',
                  style: TextStyle(
                    color: Colors.red[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: deleteFunction,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}