import 'package:floor/floor.dart';


@entity
class Airplane {

  static int ID = 1 ;

  @primaryKey
  final int airplane_id;
  final String airplaneType;
  final String PassengerNum;
  final String maxSpeed;
  final String distance;


  Airplane(this.airplane_id,this.airplaneType,this.PassengerNum,this.maxSpeed,this.distance) {
    if (airplane_id >= ID) {
      ID = airplane_id + 1;
    }
  }

}
