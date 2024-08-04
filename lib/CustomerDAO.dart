import 'package:floor/floor.dart';

import 'Customer.dart';

///This class contains the method to perform the CRUD operation.


@dao
abstract class CustomerDAO {
  @insert
  Future<void> addCustomer(Customer customer); //method for inserting the customer

  @delete
  Future<int> deleteCustomer(Customer customer); //delete the customer

  @Query("select * from Customer")
  Future<List<Customer>> getAllCustomers(); //fetch all the customer from the database_table

  @update
  Future<int> updateCustomer(Customer customer); // update the customer.

}