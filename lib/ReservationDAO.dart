import 'package:floor/floor.dart';
import 'Reservation.dart';

@dao
abstract class ReservationDAO {

  @delete
  Future<int> deleteReservation(Reservation reservation);

  @insert
  Future<void> insertReservation(Reservation reservation);

  @update
  Future<int> updateReservation(Reservation reservation);

  @Query('SELECT * FROM reservations')
  Future<List<Reservation>> getAllReservations();
}