import 'dart:convert';

import 'package:flutter/material.Dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyHttp"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : $id",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Email :$email",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Nama : $name",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                var myrespone =
                    await http.get(Uri.parse("https://reqres.in/api/users/2"));

                if (myrespone.statusCode == 200) {
                  setState(() {
                    Map<String, dynamic> data =
                        json.decode(myrespone.body) as Map<String, dynamic>;
                    // print(data);
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    name =
                        "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                  });
                } else {
                  print("ERROR ${myrespone.statusCode}");
                }
              },
              child: Text("GET Data"),
            ),
          ],
        ),
      ),
    );
  }
}
