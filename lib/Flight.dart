import 'package:floor/floor.dart';

///This class is dedicated as the flight table.
@entity
class Flight{

  static int ID = 1;

  @primaryKey
  final int flight_id;
  final String destination;
  final String source;
  final String departure;
  final String arrival;

  Flight( this.flight_id, this.destination, this.source, this.arrival, this.departure){
    if(flight_id >= ID){
      ID = flight_id + 1;
    }
  }



}