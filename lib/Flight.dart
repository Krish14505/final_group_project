import 'package:floor/floor.dart';

///This class is dedicated as the flight table.
@entity
class Flight{

  @primaryKey
  final int flight_id;
  final String destination;
  final String source;
  final int departure;
  final int arrival;

  Flight( this.flight_id, this.destination, this.source, this.arrival, this.departure);



}