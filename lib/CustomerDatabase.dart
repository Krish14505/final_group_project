import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'Customer.dart';
import 'CustomerDAO.dart';
import 'Flight.dart';
import 'FlightsDAO.dart';
import 'Reservation.dart';
import 'ReservationDAO.dart';
import 'airplane.dart';
import 'airplane_dao.dart';

part 'CustomerDatabase.g.dart';

///Customer Database class extends FloorDatabase
@Database(version: 4, entities:[Customer,Airplane,Reservation,Flight])
abstract class CustomerDatabase extends FloorDatabase {

  ///get the interface ready to database
  CustomerDAO get getCustomerDAO; // function to establish the connection.

  ///get the interface Airplane ready to Airplane
  AirplaneDao get getAirplaneDAO;

  ///get the interface ready for the reservation
  ReservationDAO get getReservationDAO;

  ///get the interface ready for the Flight
  FlightsDAO get getFlightDAO;

}