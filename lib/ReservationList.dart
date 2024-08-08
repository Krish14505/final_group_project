import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:group_project/Reservation.dart';
import 'package:group_project/ReservationDAO.dart';
import 'package:group_project/ReservationDB.dart';
import 'package:group_project/ReservationPage.dart';

class ReservationList extends StatefulWidget{
  String title = "Reservation List";

  @override
  State<ReservationList> createState(){
    return ReservationListState();
  }
}

class ReservationListState extends State<ReservationList> {

  late ReservationDAO reservationdao;

  Reservation ? selectedReservation;

  List<Reservation> reservationList = ReservationPageState.reservationList;

  late TextEditingController _reservationName;
  late TextEditingController _customerName;
  late TextEditingController _flightName;
  late TextEditingController _reservationDate;
  late TextEditingController _departureCity;
  late TextEditingController _destinationCity;
  late TextEditingController _departureTime;
  late TextEditingController _arrivalTime;


  void initstate(){
    super.initState();
    _reservationName = TextEditingController();

    $FloorReservationDB.databaseBuilder("reservation_database.db").build().then((database){
      reservationdao = database.reservationDao;

      reservationdao.getAllReservations().then((ListOfReservation){
        reservationList.addAll(ListOfReservation);
      });
    });
  }

  @override
  void dispose() {
    _reservationName.dispose();
    _customerName.dispose();
    _flightName.dispose();
    _reservationDate.dispose();
    _departureCity.dispose();
    _destinationCity.dispose();
    _departureTime.dispose();
    _arrivalTime.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
        body: responsiveLayout(),
      );
  }

  Widget responsiveLayout() {
    var size = MediaQuery
        .of(context)
        .size;
    var height = size.height;
    var width = size.width;

    //condition to check the mode of the device
    //if the width is greater than 720 and height,then it's in landscape mode
    //if not,then it is in potrait mode

    if (width > height && width > 720) {
      return Row(
        children: [
          Expanded(flex: 2, child: ListPage()),
          Expanded(flex: 3, child: ReservationDetailsWithForm()),
        ],
      );
    } else { //potrait mode
      if (selectedReservation == null) {
        return ListPage();
      } else {
        return ReservationDetailsWithForm();
      }
    }
  }
  Widget ListPage(){
    return Center(
      child:Column(
        children: [
          if(reservationList.isEmpty)
      Text("*There is no reservation added yet*",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
    else
            Flexible(
              child: ListView.builder(
                itemCount: reservationList.length,
                itemBuilder: (context, index) {
                  final reservation = reservationList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedReservation = reservation;
                        _reservationName.text = reservation.reservationName;
                        _reservationDate.text = reservation.reservationDate;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[100], // Different background color
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text('${reservation.reservationName}${reservation.reservationDate}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      )
    );
  }
  Widget ReservationDetailsWithForm(){
    if (selectedReservation == null){
      return Text("Nothing is selected");
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text("Reservation Details", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 350,
                padding: const EdgeInsets.all(10.0),

                margin: const EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(controller: _customerName,
                decoration: InputDecoration(
                  hintText: "Customer Name",
                  border: OutlineInputBorder(),
                  labelText: "Customer Name"
                ),),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 350,
                padding: const EdgeInsets.all(10.0),

                margin: const EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(controller: _flightName,
                  decoration: InputDecoration(
                      hintText: "Flight Name",
                      border: OutlineInputBorder(),
                      labelText: "Flight Name"
                  ),),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _departureCity,
                    decoration: InputDecoration(
                        hintText: "Departure City",
                        border: OutlineInputBorder(),
                        labelText: "Departure City"
                    )),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _destinationCity,
                    decoration: InputDecoration(
                        hintText: "Destination City",
                        border: OutlineInputBorder(),
                        labelText: "Destination City"
                    )),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _departureTime,
                    decoration: InputDecoration(
                        hintText: "Depature Time",
                        border: OutlineInputBorder(),
                        labelText: "Depature Time"
                    )),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _arrivalTime,
                    decoration: InputDecoration(
                        hintText: "Arrival Time",
                        border: OutlineInputBorder(),
                        labelText: "Arrival Time"
                    )),
              ),

            ],
          ),
        ],),
      );
    }
}
}