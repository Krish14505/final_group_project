import 'package:flutter/cupertino.dart';
import 'package:group_project/Flight.dart';
import 'package:group_project/FlightsDAO.dart';

class FlightsListPage extends StatefulWidget {
  String title = "Flight List Page";

  @override
  State<StatefulWidget> createState() {
    return FlightsListPageState();
  }
}

class FlightsListPageState extends State<FlightsListPage>{

  late FlightsDAO flightdao ;

  Flight ? selectedFlight;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // List<Flight> flightLists = FlightRegistration.flightList;

}

