import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int days = 30;
  final String name = "Tahmid";
  final num pi = 3.14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Catalog App")),
      ),
      drawer: Drawer(),
      body: Center(
        child: Container(
          child: Text(
              "Welcome to the $days days of first app by $name. The pi is $pi"),
        ),
      ),
    );
  }
}
