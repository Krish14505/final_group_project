
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/airplane.dart';

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
  static List<Flight> flightList = [ ];



  late int selected;
  late TextEditingController _destinationController ;
  late TextEditingController _sourceController ;
  late TextEditingController _departureController ;
  late TextEditingController _arrivalController ;

  //use the encrypted shared preferences
  late EncryptedSharedPreferences savedFlight;

  @override
  void dispose() {
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController = TextEditingController();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController();
    _sourceController = TextEditingController();
    _departureController = TextEditingController();
    _arrivalController  =TextEditingController();

    //pending the database  thing
    final migration3to4 = Migration(3, 4, (database) async {
      await database.execute(
        "CREATE TABLE IF NOT EXISTS `Flights` (`flight_id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `destination` TEXT, `source` TEXT, `departure` TEXT, `arrival` TEXT)",
      );
    });

    $FloorCustomerDatabase.databaseBuilder("app_database.db").addMigrations([migration3to4]).build().then((database) {
        flightsDAO = database.getflightsDAO;

        flightsDAO.getAllFlights().then((listofFlights) {
          flightList.addAll(listofFlights);
        });
    });

    savedFlight = EncryptedSharedPreferences();

    savedData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Flight Registration",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300, // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0), // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _destinationController,
                      decoration: InputDecoration(
                          hintText:"Please enter the destination",
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
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300, // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0), // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _sourceController,
                      decoration: InputDecoration(
                          hintText:"please enter source",
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
                ElevatedButton(style: ElevatedButton.styleFrom(elevation: 0),onPressed: () {  }, child: Icon(Icons.airplane_ticket)),
                //column for the other field
                Container(
                  width: 300, // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0), // Optional: Add padding
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10), // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _departureController,
                      decoration: InputDecoration(
                          hintText:"please enter the departure",
                          border: OutlineInputBorder(),
                          labelText: "departure"
                      )),
                ),
              ],
            ),





          ],
        ),
      ),
    );
  }


  }
