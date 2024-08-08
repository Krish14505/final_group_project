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

    final migration1to2 = Migration(1, 2, (database) async {
      await database.execute(
        "CREATE TABLE IF NOT EXISTS `Airplane` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `airplaneType` TEXT, `PassengerNum` TEXT, `maxSpeed` TEXT, `distance` TEXT)",
      );
    });

    //creating the database connection
    $FloorProjectDatabase.databaseBuilder("app_database.db").addMigrations([migration1to2]).build().then((database) {
      AirplaneDAO = database.getAirplaneDAO; // instantiate the database object
      AirplaneDAO.getAllAirPlanes().then((listOfAirplanes) {
        airplaneLists.addAll(listOfAirplanes);
      });
    });

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
                      _number_passenger.text = airplane.number_passenger;
                      _maximum_speed.text = airplane.maximum_speed;
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
                          .number_passenger}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .bold)),
                      subtitle: Text(
                          airplane.maximum_speed, style: TextStyle(fontSize: 14)),
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
              Text("Airplne Details", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),


              ///first row for the
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

                ],),

              //Updated and deleted

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 20,),
                  Expanded(flex: 2,
                      child: FilledButton(
                          onPressed: UpdateAirplane, child: Text("Update"))),
                  SizedBox(width: 20,),
                  Expanded(flex: 2,
                      child: FilledButton(
                          onPressed: deleteAirplane, child: Text("Delete"))),
                ],
              )


            ])
    );
  }
}

  void UpdateAirplane(){
    if(selectedAirplane != null) {
      Airplane updatedAirplane = Airplane(
          selectedAirplane!.id,
          _airplaneType.text,
          _number_passenger.text,
          _maximum_speed.text,
          _distance.text,

      );

      AirplaneDAO.updateAirplane(updatedAirplane).then((value) {
        //gui to react
        setState(() {


          int index = airplaneLists.indexWhere((airplane) => airplane.id == selectedAirplane!.id);

          if(index != null) {
            airplaneLists[index] = updatedAirplane;
          }
          selectedAirplane = updatedAirplane;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Airplane Details updated successfully',style: TextStyle(color: Colors.lightGreen),)));
      });
    }
  }

  void deleteAirplane(){
    setState(() {

      AirplaneDAO.deleteAirplane(selectedAirplane!);

      airplaneLists.remove(selectedAirplane);

      //make the selectedAirplane to be null
      selectedAirplane = null;
    });

  }


} //end of AirplaneListPage class

