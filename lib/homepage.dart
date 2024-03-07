import 'dart:convert';
import 'package:book_app/Models/books_model.dart';
import 'package:book_app/managepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Entries> entries = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book),
            SizedBox(
              width: 10,
            ),
            Text("Welcome!       "),
          ],
        ),
      ),

      body: ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 18,),
              child: Card(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                    Text(
                      entries[index].aPI,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Text(
                      "Caragory : " + entries[index].category,
                      style: TextStyle(color: Colors.orange[300], fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "To know about " + entries[index].description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    ),
                    Link(
                        uri: Uri.parse(entries[index].link),
                        target: LinkTarget.blank,
                        builder: (context, followLink) {
                          return ElevatedButton(
                              onPressed: followLink,
                              child: Text("Check details"));
                        }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }),

          drawer:  Drawer(
            backgroundColor: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("H O M E"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text("M A N A G E"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> ManagePage(),
                      ));
                    },
                  ),
                ),
                SizedBox(height: 60,),

              ],
            ),
          ),

      // floatingActionButton: FloatingActionButton(onPressed: fetchData,),
    );
  }





  Future<void> fetchData() async {
    final url = Uri.parse("https://api.publicapis.org/entries");
    final response = await http.get(url);
    var json = jsonDecode(response.body);
    final entry = json['entries'] as List<dynamic>;
    setState(() {
      entries = entry.map((e) {
        return Entries(
            aPI: e['API'],
            description: e['Description'],
            auth: e['Auth'],
            hTTPS: e['HTTPS'],
            cors: e['Cors'],
            link: e['Link'],
            category: e['Category']);
      }).toList();

      count = json["count"];
    });
  }
}
