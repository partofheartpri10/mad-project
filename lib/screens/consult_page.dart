import 'package:flutter/material.dart';


class ConsultPage extends StatefulWidget {
  @override
  _ConsultPageState createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
        onPressed: (){},
        child: Icon(Icons.phone),
      ),
      body: Center(
        child: Text("Consult"),
      ),
    );
  }
}
