import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'Customer.dart';
import 'CustomerDAO.dart';
import 'airplane.dart';
import 'airplane_dao.dart';

part 'CustomerDatabase.g.dart';

///Customer Database class extends FloorDatabase
@Database(version: 2, entities:[Customer,Airplane])
abstract class CustomerDatabase extends FloorDatabase {

  ///get the interface ready to database
  CustomerDAO get getCustomerDAO; // function to establish the connection.

  ///get the interface Airplane ready to database
  AirplaneDao get getAirplaneDAO;
}