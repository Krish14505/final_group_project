import 'package:floor/floor.dart';
import 'Reservation.dart';

@dao
abstract class ReservationDAO {
  @Query('SELECT * FROM Reservation')
  Future<List<Reservation>> fetchAllReservations();

  @delete
  Future<int> deleteReservation(Reservation reservation);

  @insert
  Future<void> insertReservation(Reservation reservation);

  @update
  Future<int> updateReservation(Reservation reservation);

  @Query('SELECT * FROM Reservation')
  Future<List<Reservation>> getAllReservations();
}