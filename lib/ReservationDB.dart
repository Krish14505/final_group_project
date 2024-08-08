import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'Reservation.dart';
import 'ReservationDAO.dart';

part 'ReservationDB.g.dart'; // Ensure this file exists and is in the same directory

@Database(version: 1, entities: [Reservation])
abstract class ReservationDB extends FloorDatabase {
  ReservationDAO get reservationDao;
}