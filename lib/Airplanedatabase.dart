import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'airplane.dart';
import 'airplane_dao.dart';
part 'airplanedatabase.g.dart';

@Database(version: 1, entities:[Airplane])
abstract class AirplaneDatabase extends FloorDatabase {
  //get the interface ready to database
  AirplaneDao get getAirplaneDAO;
}
