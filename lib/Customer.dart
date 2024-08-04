
import 'package:floor/floor.dart';

///This class is dedicated as the customer table.
@entity
class Customer {

  static int ID = 1 ;

  ///Primary key of the customers table and other variables
  @primaryKey
  final int customer_id ;
  final String first_name;
  final String last_name;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthday;


  ///constructor
  Customer(this.customer_id,this.first_name,this.last_name,this.email,this.phoneNumber,this.address,this.birthday) {

    if (customer_id >= ID)
      ID = customer_id + 1; // when loading the page, if the customer_id is more than the ID(1) then it increment the customer_id by 1 and then
                            //oj

  }
}