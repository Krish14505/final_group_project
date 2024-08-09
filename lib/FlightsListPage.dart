import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Flight.dart';
import 'package:group_project/FlightsDAO.dart';

import 'FlightRegistration.dart';
import 'ProjectDatabase.dart';

class FlightsListPage extends StatefulWidget {
  String title = "Flight List Page";

  @override
  State<StatefulWidget> createState() {
    return FlightsListPageState();
  }
}

class FlightsListPageState extends State<FlightsListPage> {
  late FlightsDAO flightsDAO;

  Flight? selectedFlight;

  List<Flight> flightList = FlightListPageState.flightList;

  late TextEditingController _destinationController;

  late TextEditingController _sourceController;

  late TextEditingController _departureController;

  late TextEditingController _arrivalController;

  @override
  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController = TextEditingController();

    $FloorProjectDatabase
        .databaseBuilder("app_database.db")
        .build()
        .then((database) {
      flightsDAO = database.getFlightDAO;

      flightsDAO.getAllFlights().then((listofFlights) {
        flightList.addAll(listofFlights);
      });
    });
  }

  @override
  void dispose() {
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController = TextEditingController();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: responsiveLayout(),
    );
  }

//responsive layout

  Widget responsiveLayout() {
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;

    if (width > height && width > 720) {
      return Row(
        children: [
          Expanded(flex: 2, child: ListPage()),
          Expanded(flex: 3, child: flightDetailsWithForm()),
        ],

      );
    } else {
      if (selectedFlight == null) {
        return ListPage();
      } else {
        return flightDetailsWithForm();
      }
    }
  }

  Widget ListPage() {
    return Center(
      child: Column(

        children: [

          if(flightList.isEmpty)
            Text("No Flights added",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          else
            Flexible(
                child: ListView.builder(
                    itemCount: flightList.length,
                    itemBuilder: (context, index) {
                      final flight = flightList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFlight = flight;
                            _departureController.text = flight.departure;
                            _destinationController.text = flight.destination;
                            _sourceController.text = flight.source;
                            _arrivalController.text = flight.arrival;
                          }
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            // Different background color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text('${flight.source} ${flight
                                .destination}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight
                                    .bold)),
                            subtitle: Text(
                                flight.departure, style: TextStyle(
                                fontSize: 14)),
                          ),
                        )
                        ,
                      );
                    }

                )
            )

        ],
      ),
    );
  }

  Widget flightDetailsWithForm() {
    if (selectedFlight == null) {
      return Text("Nothing is selected yet !");
    }
    else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Flight Details", style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300,
                  // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0),
                  // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _destinationController,
                      decoration: InputDecoration(
                          hintText: "Please enter the destination",
                          border: OutlineInputBorder(),
                          labelText: "destination"
                      )),
                ),
              ],
            ),

            //second TextField
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300,
                  // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0),
                  // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _sourceController,
                      decoration: InputDecoration(
                          hintText: "please enter source",
                          border: OutlineInputBorder(),
                          labelText: "Source"
                      )),
                ),
              ],
            ),

            //third Textfield
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300,
                  // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0),
                  // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _departureController,
                      decoration: InputDecoration(
                          hintText: "please enter the departure",
                          border: OutlineInputBorder(),
                          labelText: "departure"
                      )),
                ),
              ],
            ),


            //fourth Textfield
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300,
                  // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0),
                  // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _arrivalController,
                      decoration: InputDecoration(
                          hintText: "please enter the arrival",
                          border: OutlineInputBorder(),
                          labelText: "arrival"
                      )),
                ),
              ],
            ),

            //creating update and delete button  for  the user as the customer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20,),
                Expanded(flex: 2,
                    child: FilledButton(
                        onPressed: updateFlight, child: Text("Update"))),
                SizedBox(width: 20,),
                Expanded(flex: 2,
                    child: FilledButton(
                        onPressed: deleteFlight, child: Text("Delete"))),
              ],
            )

          ],
        ),
      );
    }
  }

  //function for the update Flight
  void updateFlight() {
    if (selectedFlight != null) {
      Flight updatedFlight = Flight(
          selectedFlight!.flight_id,
          _destinationController.text,
          _sourceController.text,
          _arrivalController.text,
          _departureController.text
      );
      flightsDAO.updateFlight(updatedFlight).then((value) {
        setState(() {
          int index = flightList.indexWhere((flight) =>
          flight.flight_id == selectedFlight!.flight_id);

          if (index != null) {
            flightList[index] = updatedFlight;
          }
          selectedFlight = updatedFlight;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          ' Flight details updated successfully',
          style: TextStyle(color: Colors.deepOrange),)));
      });
    }
  }

//flight deletion method
  void deleteFlight() {
    setState(() {
      flightsDAO.deleteFlight(selectedFlight!);

      flightList.remove(selectedFlight);

      //mke the selectedFlight to be null
      selectedFlight = null;
    });
  }


} // end of the flightList page