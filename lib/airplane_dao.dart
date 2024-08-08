import 'package:floor/floor.dart';

import 'airplane.dart';

///This class conatins the methods to perform the Crud operation
@dao
abstract class AirplaneDao {

  @insert
  Future<void> insertAirplane(Airplane airplane);

  @delete
  Future<int> deleteAirplane(Airplane airplane);

  @Query("select * from Airplane")
  Future<List<Airplane>> getAllAirPlanes();

  @update
  Future<int> updateAirplane(Airplane airplane);
}