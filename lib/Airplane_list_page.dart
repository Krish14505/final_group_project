import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'AirplaneRegisterpage.dart';
import 'airplane.dart';
import 'airplane_dao.dart';


class AirplaneListPage extends StatefulWidget {
  String title = "Airplane list page";

  @override
  State<AirplaneListPage> createState() {
    return AirplaneListPageState();
  }
}

class AirplaneListPageState extends State<AirplaneListPage> {

  late AirplaneDao AirplaneDAO;

  Airplane ? selectedAirplane;


  List<Airplane> airplaneLists = AirplaneRegistrationState.airplaneList;

  late TextEditingController _airplaneType;
  late TextEditingController _number_passenger;
  late TextEditingController _maximum_speed;
  late TextEditingController _distance;



  @override
  void initState() {
    _airplaneType = TextEditingController();
    _number_passenger = TextEditingController();
    _maximum_speed = TextEditingController();
    _distance = TextEditingController();
  }


  @override
  void dispose() {
    _airplaneType.dispose();
    _number_passenger.dispose();
    _maximum_speed.dispose();
    _distance.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: responsiveLayout(),);
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
        Expanded(flex: 3, child: airplaneDetailsWithForm()),
      ],

    );
  } else {
    if (selectedAirplane == null) {
      return ListPage();
    } else {
      return airplaneDetailsWithForm();
    }
  }
}

Widget ListPage() {
  return Center(
    child: Column(
      children: [

        if(airplaneLists.isEmpty)
          Text("*No airplane info Added*",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
        else
          Flexible(
            child: ListView.builder(
              itemCount: airplaneLists.length,
              itemBuilder: (context, index) {
                final airplane = airplaneLists[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAirplane = airplane;
                      _airplaneType.text = airplane.airplaneType;
                      _number_passenger.text = airplane.PassengerNum;
                      _maximum_speed.text = airplane.maxSpeed;
                      _distance.text = airplane.distance;

                    }
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[100], // Different background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('${airplane.airplaneType} ${airplane
                          .PassengerNum}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .bold)),
                      subtitle: Text(
                          airplane.maxSpeed, style: TextStyle(fontSize: 14)),
                    ),
                  ),
                );
              },
            ),
          )

      ],),
  );
}

Widget airplaneDetailsWithForm() {
  if (selectedAirplane == null) {
    return Text("Nothing is selected ");
  } else {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 20),
              Text("Customer Details", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),


              ///first row for the customer last name and first name.
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
                    child: TextField(controller: _airplaneType,
                        decoration: InputDecoration(
                            hintText: "Enter  Airplane Type",
                            border: OutlineInputBorder(),
                            labelText: "Airplane Type"
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

                    child: TextField(controller: _number_passenger,
                        decoration: InputDecoration(
                            hintText: "Enter Number of Passengers",
                            border: OutlineInputBorder(),
                            labelText: "Number of Passengers"
                        )),
                  ),

                ],),

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
                      child: TextField(controller: _maximum_speed,
                          decoration: InputDecoration(
                              hintText: "Enter Maximum Speed",
                              border: OutlineInputBorder(),
                              labelText: "Maximum Speed"
                          )),
                    ),
                  ]),
              //Row for the Phone Number
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                    child: TextField(controller: _distance,
                        decoration: InputDecoration(
                            hintText: "Enter Diastance",
                            border: OutlineInputBorder(),
                            labelText: "Diatance"
                        )),
                  ),

                ],)
            ])
    );
  }
}
///krish chaudhary
  ///function to update the customer when he click on the update button
  void UpdateCustomer(){
    if(selectedAirplane != null) {
      //creating an instance of the updated customer.
      Airplane updatedAirplane = Airplane(
          selectedAirplane!.airplane_id, // fetch the selected customer_id from the database.
          //use the updated text value to update the customer entry.
          _airplaneType.text,
          _number_passenger.text,
          _maximum_speed.text,
          _distance.text,

      );

      //call the dao UpdatedCustomer(Customer) method.
      AirplaneDAO.updateAirplane(updatedAirplane).then((value) {
        //gui to react
        setState(() {


          //update the customer to the list.
          int index = airplaneLists.indexWhere((airplane) => airplane.airplane_id == selectedAirplane!.airplane_id);

          if(index != null) {
            airplaneLists[index] = updatedAirplane;
          }
          selectedAirplane = updatedAirplane;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Customer updated successfully',style: TextStyle(color: Colors.lightGreen),)));
      });
    }
  }

  ///Function That run when deleting  customer
  void DeleteAirplane(){
    setState(() {

      //delete the customer from the database first
      AirplaneDAO.deleteAirplane(selectedAirplane!);

      //and then remove from the customer
      airplaneLists.remove(selectedAirplane);

      //make the selectedAirplane to be null
      selectedAirplane = null;
    });

  }


} //end of CustomerListPageState class

