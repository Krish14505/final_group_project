import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Reservation.dart';
import 'package:group_project/ReservationDAO.dart';
import 'package:group_project/CustomerDAO.dart';
import 'package:group_project/CustomerDatabase.dart';
import 'CustomerDAO.dart';
import 'CustomerDAO.dart';
import 'ReservationDB.dart';

class ReservationPage extends StatefulWidget {
  @override
  State<ReservationPage> createState() => ReservationPageState();
}

class ReservationPageState extends State<ReservationPage> {
  late ReservationDAO reservationDAO;
  static List<Reservation> reservationList = [];

  String? selectedCustomer;
  String? selectedFlight;
  List<String> customers = [];
  List<String> flights = [];
  DateTime? _reservationDate;
  late TextEditingController _reservationName;

  @override
  void initState() {
    super.initState();
    _reservationName = TextEditingController();
    loadData();
  }


  void loadData() async {
    //final Cdatabase = await CustomerDatabase.databaseBuilder('customer_db').build();
    //final Fdatabase = await FlightDatabase.databaseBuilder('flight_db').build();
    //customers = await Cdatabase.customerDao.getAllCustomers();
    //flights = await Fdatabase.flightDao.getAllFlights();
    setState(() {});
  }

  void _addReservation() async {
    if (selectedCustomer == null || selectedFlight == null || _reservationDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final reservation = Reservation(
      reservationId: 0,
      customerName: selectedCustomer!,
      flightName: selectedFlight!,
      reservationName: _reservationName.text,
      reservationDate: _reservationDate!,
    );

    final database = await $FloorReservationDB.databaseBuilder('app_database.db').build();
    await database.reservationDao.insertReservation(reservation);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reservation added')),
    );


    // Reload the data to update the ListView
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Page'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Instructions'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('1. Adding a Reservation:'),
                        Text('   - Enter the name of the reservation in the text field provided.'),
                        Text('   - Press the "Add Reservation" button to add the reservation to the list.'),
                        SizedBox(height: 10),
                        Text('2. Viewing Reservation Details:'),
                        Text('   - Tap on any reservation in the list to view its details.'),
                        SizedBox(height: 10),
                        Text('3. Copying Previous Customer Information:'),
                        Text('   - When adding a new customer, you can choose to copy the information from the previous customer.'),
                        SizedBox(height: 10),
                        Text('4. Navigation:'),
                        Text('   - Use the back button or the app\'s navigation controls to go back to the home page or other sections of the app.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCustomer,
              hint: Text('Select Customer'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCustomer = newValue;
                });
              },
              items: customers.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedFlight,
              hint: Text('Select Flight'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFlight = newValue;
                });
              },
              items: flights.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _reservationName,
              decoration: InputDecoration(
                hintText: "Enter Reservation Name",
                border: OutlineInputBorder(),
                labelText: "Reservation Name",
              ),
              maxLength: 30,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _reservationDate = pickedDate;
                  });
                }
              },
              child: Text('Select Reservation Date'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            if (_reservationDate != null)
              Text(
                'Selected Date: ${_reservationDate!.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addReservation,
              child: Text('Add Reservation'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reservationList.length,
                itemBuilder: (context, index) {
                  final reservation = reservationList[index];
                  return ListTile(
                    title: Text(reservation.reservationName),
                    subtitle: Text('Customer: ${reservation.customerName}, Flight: ${reservation.flightName}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationDetailPage(reservation: reservation),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationDetailPage extends StatelessWidget {
  final Reservation reservation;

  ReservationDetailPage({required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reservation Name: ${reservation.reservationName}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Customer: ${reservation.customerName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Flight: ${reservation.flightName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Reservation Date: ${reservation.reservationDate.toLocal().toString().split(' ')[0]}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
