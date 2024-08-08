import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomerDatabase.dart';
import 'Flight.dart';
import 'FlightsDAO.dart';

class FlightListPage extends StatefulWidget{

  String title = "Flight List Page";
  @override
  State<StatefulWidget> createState() {

    return flightListPageState();
  }


}

class flightListPageState extends State<FlightListPage>{

  late FlightsDAO flightsDAO;
  late Future<List<Flight>> flights;
  late List<Flight> flightsNow;

  bool addMode = true;
  int buttonCount = 0;

  late int selected;
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();


  @override
  void initState() {
    super.initState();
    flights = initializeDatabase();

  }

  Future<List<Flight>> initializeDatabase() async {
    final database = await $FloorCustomerDatabase.databaseBuilder("app_database.db").build();
    flightsDAO = database.flightsDAO;
    Future<List<Flight>> fs = flightsDAO.getAllFlights();
    flightsNow = await fs;
    return fs;
  }

  ElevatedButton makeFlightButton(Flight flight){

    return ElevatedButton(
      onPressed: () {
        addMode = false;
        selected = buttonCount++;
        setState(() {});
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Square edges
        ),
        minimumSize: Size(double.infinity, 50), // Make button long
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Destination: ${flight.destination}  Source: ${flight.source}',
            textAlign: TextAlign.left,
          ),
          Text(
            'Departure: ${flight.departure}  Arrival: ${flight.arrival}',
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }


void addFlight() async{
    Flight f = Flight(Flight.ID,destinationController.text,sourceController.text,
        int.parse(arrivalController.text),int.parse(departureController.text));
    flightsDAO.addFlight(f);
    flightsNow.add(f);
    setState(() {});
}

void removeFlight() async{
    flightsDAO.deleteFlight(flightsNow.elementAt(selected));
    flightsNow.removeAt(selected);
    setState(() {});
}

void updateFlight() async{
    int id = flightsNow.elementAt(selected).flight_id;
    flightsDAO.deleteFlight(flightsNow.elementAt(selected));
    Flight f = Flight(id,destinationController.text,sourceController.text,
        int.parse(arrivalController.text),int.parse(departureController.text));
    flightsDAO.addFlight(f);
    flightsNow.removeAt(selected);
    flightsNow.insert(selected, f);
    setState(() {});
}

Row getButtons() {
    if(addMode){
      return Row(
        children: [
          ElevatedButton(onPressed:() {
            addFlight();
            }, child: Text("Add"))
        ],
      );
    }
    return Row(
      children: [
        ElevatedButton(onPressed: (){
          updateFlight();
          }, child: Text("Update")),
        ElevatedButton(onPressed: (){
          removeFlight();
          }, child: Text("Delete"))
      ],
    );
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
          getButtons(),
      FutureBuilder<List<Flight>>(
        future: flights,
        builder: (BuildContext context, AsyncSnapshot<List<Flight>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Wrap(
              spacing: 8.0, // Space between buttons
              runSpacing: 4.0, // Space between lines
              children: snapshot.data!.map((flight) => makeFlightButton(flight)).toList(),
            );
          } else {
            return Text('No flights available');
          }
        },
      ),
        ],
      ),
    );
  }}
