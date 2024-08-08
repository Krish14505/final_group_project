import 'package:floor/floor.dart';
import 'DateTimeConverter.dart';

 // Adjust import as needed

@Entity(tableName: 'reservations')
class Reservation {
  @primaryKey
  final int reservationId;
  final String customerName;
  final String flightName;

  @TypeConverters([DateTimeConverter]) // Convert DateTime to/from int
  final DateTime reservationDate;

  final String reservationName;

  Reservation({
    required this.reservationId,
    required this.customerName,
    required this.flightName,
    required this.reservationDate,
    required this.reservationName,
  });
}
