import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightListPage extends StatefulWidget{

  String title = "Flight List Page";
  @override
  State<StatefulWidget> createState() {
    return flightListPageState();
  }


}

class flightListPageState extends State<FlightListPage>{

  final TextEditingController destinationController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          TextField(
            controller: destinationController,
            decoration: InputDecoration(
              hintText: "somewhere",
            ),
          ),
          TextField(
            controller: sourceController,
            decoration: InputDecoration(
              hintText: "somewhere else",
            ),
          ),
          TextField(
            controller: arrivalController,
            decoration: InputDecoration(
              hintText: "sometime",
            ),
          ),
          TextField(
            controller: departureController,
            decoration: InputDecoration(
              hintText: "sometime earlier",
            ),
          ),
        ],
      ),
    );
  }

}