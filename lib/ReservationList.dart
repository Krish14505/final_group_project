import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/ProjectDatabase.dart';

import 'Reservation.dart';
import 'ReservationDAO.dart';
import 'ReservationPage.dart';

class ReservationList extends StatefulWidget {
  String title = "Reservation List";

  @override
  State<ReservationList> createState() {
    return ReservationListState();
  }
}

class ReservationListState extends State<ReservationList> {
  late ReservationDAO reservationdao;

  Reservation? selectedReservation;

  List<Reservation> reservationList = []; // Initialize as an empty list

  late TextEditingController _reservationName;
  late TextEditingController _customerName;
  late TextEditingController _reservationDate;
  late TextEditingController _depatureCity;
  late TextEditingController _destinationCity;
  late TextEditingController _depatureTime;
  late TextEditingController _arrivalTime;

  @override
  void initState() {
    super.initState();

    _reservationName = TextEditingController();
    _customerName = TextEditingController();
    _reservationDate = TextEditingController();
    _depatureCity = TextEditingController();
    _destinationCity = TextEditingController();
    _depatureTime = TextEditingController();
    _arrivalTime = TextEditingController();

    final migration2to3 = Migration(2, 3, (database) async {
      await database.execute(
          "CREATE TABLE IF NOT EXISTS 'reservations' (`reservationId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `reservationDate` TEXT, `reservationName` TEXT)");
    });

    // Creating the database connection
    $FloorProjectDatabase.databaseBuilder("app_database.db")
        .addMigrations([migration2to3])
        .build()
        .then((database) {
      reservationdao = database.getReservationDAO;
      reservationdao.getAllReservations().then((listofReservation) {
        setState(() {
          reservationList = listofReservation; // Set the list directly
        });
      });
    });
  }

  @override
  void dispose() {
    _reservationName.dispose();
    _customerName.dispose();
    _reservationDate.dispose();
    _depatureCity.dispose();
    _destinationCity.dispose();
    _depatureTime.dispose();
    _arrivalTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

    if (width > height && width > 720) {
      return Row(
        children: [
          Expanded(flex: 2, child: ListPage()),
          Expanded(flex: 3, child: ReservationDetailsWithForm()),
        ],
      );
    } else {
      if (selectedReservation == null) {
        return ListPage();
      } else {
        return ReservationDetailsWithForm();
      }
    }
  }

  Widget ListPage() {
    return Center(
      child: Column(
        children: [
          if (reservationList.isEmpty)
            Text("*There is no reservation added yet*",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
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
                      margin:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                            '${reservation.reservationName} ${reservation
                                .reservationDate}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }

  Widget ReservationDetailsWithForm() {
    if (selectedReservation == null) {
      return Center(child: Text("Nothing is selected"));
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text("Reservation Details",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
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
                  child: TextField(
                    controller: _reservationName,
                    decoration: InputDecoration(
                        hintText: "Reservation Name",
                        border: OutlineInputBorder(),
                        labelText: "Reservation Name"),
                  ),
                ),
              ],
            ),
            // Add more fields as needed in a similar fashion
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
                  child: TextField(
                    controller: _reservationDate,
                    decoration: InputDecoration(
                        hintText: "Reservation Date",
                        border: OutlineInputBorder(),
                        labelText: "Reservation Date"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20,),
                Expanded(flex: 2,
                    child: FilledButton(
                        onPressed: DeleteReservation, child: Text("Delete"))),
              ],
            )
            // Add more TextFields for other details if needed
          ],
        ),
      );
    }
  }

  void DeleteReservation() {
    setState(() {
      //delete the customer from the database first
      reservationdao.deleteReservation(selectedReservation!);

      setState(() {
        //and then remove from the customer
        reservationList.remove(selectedReservation);
      });
    });
    selectedReservation = null;
  }
}
