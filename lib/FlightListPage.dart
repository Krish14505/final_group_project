import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/FlightDatabase.dart';
import 'package:group_project/FlightsDAO.dart';

import 'Flight.dart';

class FlightListPage extends StatefulWidget{

  String title = "Flight List Page";
  @override
  State<StatefulWidget> createState() {

    return flightListPageState();
  }


}

class flightListPageState extends State<FlightListPage>{

  late FlightsDAO flightsdao;
  late List<Flight> flights;
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();


  @override
  void initState() {
    super.initState();

    $FloorFlightDatabase.databaseBuilder("app_database.db").build().then((database) {
      flightsdao = database.flightsDAO; // instantiate the database object

      flightsdao.getAllFlights().then((listOfFlights) {
        setState(() {
          flights.addAll(listOfFlights);
        });
      });
    });


  }

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
          if (flights.isNotEmpty) Text(flights.first.destination) else Text("No flights available")
        ],
      ),
    );
  }

}