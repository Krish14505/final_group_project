import 'package:floor/floor.dart';

 // Adjust import as needed

@Entity(tableName: 'reservations')
class Reservation {
  static int ID = 1 ;

  @primaryKey
  final int reservationId;
  final String reservationDate;
  final String reservationName;

  Reservation(this.reservationId,this.reservationDate,this.reservationName) {

    if (reservationId>= ID)
      ID = reservationId + 1; // when loading the page, if the customer_id is more than the ID(1) then it increment the customer_id by 1 and then
    //oj

  }
}
