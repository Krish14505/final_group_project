import 'package:floor/floor.dart';

import 'Flight.dart';

///This class contains the method to perform the CRUD operation.


@dao
abstract class FlightsDAO {
  @insert
  Future<void> addFlight(Flight flight); //method for inserting the flight

  @delete
  Future<int> deleteFlight(Flight flight); //delete the flight

  @Query("select * from Flight")
  Future<List<Flight>> getAllFlights(); //fetch all the flights from the database_table

  @update
  Future<int> updateFlight(Flight flight); // update the flight.

}