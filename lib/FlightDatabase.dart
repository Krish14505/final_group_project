import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:group_project/FlightsDAO.dart';

import 'Flight.dart';

part 'FlightDatabase.g.dart';

@Database(version: 1, entities:[Flight])
abstract class FlightDatabase extends FloorDatabase {

  //get the interface ready to database
  FlightsDAO get flightsDAO; // function to establish the connection.

}