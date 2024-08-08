import 'package:floor/floor.dart';


@entity
class Airplane {

  static int ID = 1 ;

  @primaryKey
  final int id;
  final String airplaneType;
  final String number_passenger;
  final String maximum_speed;
  final String distance;


  Airplane(this.id,this.airplaneType,this.number_passenger,this.maximum_speed,this.distance) {
    if (id >= ID) {
      ID = id + 1;
    }
  }



}
