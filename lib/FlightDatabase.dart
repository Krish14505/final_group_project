import 'package:floor/floor.dart';
import 'package:group_project/FlightsDAO.dart';

import 'Flight.dart';

@Database(version: 1, entities:[Flight])
abstract class CustomerDatabase extends FloorDatabase {

  //get the interface ready to database
  FlightsDAO get getFlightsDAO; // function to establish the connection.

}