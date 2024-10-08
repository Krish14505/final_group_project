import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_annotation/floor_annotation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'Customer.dart';
import 'CustomerDAO.dart';
import 'Flight.dart';
import 'FlightsDAO.dart';
import 'Reservation.dart';
import 'ReservationDAO.dart';
import 'airplane.dart';
import 'airplane_dao.dart';

part 'ProjectDatabase.g.dart';

///Customer Database class extends FloorDatabase
///database with version 1 when creating the 4 entities into the database
@Database(version: 1, entities: [Customer,Reservation,Flight,Airplane])
abstract class ProjectDatabase extends FloorDatabase {

  ///get the interface ready to database
  CustomerDAO get getCustomerDAO; // function to establish the connection.

  ///get the interface Airplane ready to Airplane
  AirplaneDao get getAirplaneDAO;

  ///get the interface ready for the reservation
  ReservationDAO get getReservationDAO;

  ///get the interface ready for the Flight
  FlightsDAO get getFlightDAO;

}