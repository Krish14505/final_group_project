import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_project/Customer.dart';
import 'package:group_project/CustomerDAO.dart';
import 'package:group_project/Customer_Registration.dart';

import 'CustomerDatabase.dart';

/**
 * This customer list page has two pages: first on the left-hand side it has all the customer
 * that are in the database and on the right-hand side the customer information page in the form view with two
 * buttons 1)update(saves the data) 2)delete(delete the customer from the database)
 */
class CustomerListPage extends StatefulWidget {
  String title = "Customer List Page";

  @override
  State<CustomerListPage> createState() {
    return CustomerListPageState();
  }
}

class CustomerListPageState extends State<CustomerListPage> {
  //variables defined
  late CustomerDAO customerdao ;
  Customer ? selectedCustomer;

  List<Customer> customerLists = CustomerRegistrationState.customerLists;
  ///declare all the variables used in the textfield.
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late TextEditingController _birthday;




  @override
  void initState() {
    super.initState(); // initialize all the late variables .
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    _address = TextEditingController();
    _birthday = TextEditingController();

    //creating the database connection
    $FloorCustomerDatabase.databaseBuilder("app_database.db").build().then((database) {
      customerdao = database.getCustomerDAO; // instantiate the database object

      //fetch the customer from the customerList and put all into the database
      customerdao.getAllCustomers().then((ListOfCustomers) {
        customerLists.addAll(ListOfCustomers); // when loading the page , all the existing customer should be in the list.

      });

    });
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _address.dispose();
    _birthday.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.title,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: responsiveLayout(),
    );
  }

  //the widget to return the based on the device mode.
 Widget responsiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    //condition to check the mode of the device
    //if the width is greater than 720 and height,then it's in landscape mode
    //if not,then it is in potrait mode

   if(width > height && width > 720){
     return Row (
       children: [
         Expanded(flex: 2 , child:ListPage()),
         Expanded(flex:3, child: customerDetailsWithForm()),
       ],
     );
   }else { //potrait mode
      if(selectedCustomer == null) {
        return ListPage();
      }else {
        return customerDetailsWithForm();
      }
   }
 }



  Widget ListPage(){
    return Center(
      child: Column(
        children: [

          if(customerLists.isEmpty)
            Text("*There is no Customer added yet*",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
          else
            Flexible(
              child: ListView.builder(
                itemCount: customerLists.length,
                itemBuilder: (context, index) {
                  final customer = customerLists[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCustomer = customer;
                        _firstName.text = customer.first_name;
                        _lastName.text = customer.last_name;
                        _email.text = customer.email;
                        _phoneNumber.text = customer.phoneNumber;
                        _address.text = customer.address;
                        _birthday.text = customer.birthday;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[100], // Different background color
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text('${customer.first_name} ${customer.last_name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text(customer.email, style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  );
                },
              ),
            )

        ],),
    );
  }


//customerDetailsWithForm() that has the format of registration page but in the TextField values would that of the customer selected.

Widget customerDetailsWithForm() {
  if (selectedCustomer == null) {
    return Text("Nothing is selected ");
  } else {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 20),
          Text("Customer Details", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic)),


          ///first row for the customer last name and first name.
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _firstName,
                    decoration: InputDecoration(
                        hintText: "Enter  First Name",
                        border: OutlineInputBorder(),
                        labelText: "First Name"
                    )),
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //column for the other field
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _lastName,
                    decoration: InputDecoration(
                        hintText: "Enter Last Name",
                        border: OutlineInputBorder(),
                        labelText: "Last Name"
                    )),
              ),

            ],
          ),


          Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                //column for the other field
                Container(
                  width: 350,
                  // Adjust the width as needed
                  padding: const EdgeInsets.all(10.0),
                  // Optional: Add padding
                  margin: const EdgeInsets.all(10.0),
                  // Optional: Add margin
                  decoration: BoxDecoration(
                    color: Colors.white, // Optional: Add background color
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Add border radius

                  ),
                  child: TextField(controller: _birthday,
                      decoration: InputDecoration(
                          hintText: "Enter Date Of Birth",
                          border: OutlineInputBorder(),
                          labelText: "BirthDate"
                      )),
                ),
              ]),
          //Row for the Phone Number
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _email,
                    decoration: InputDecoration(
                        hintText: "Enter Your Email address",
                        border: OutlineInputBorder(),
                        labelText: "Email"
                    )),
              ),

            ],),

          //Row for the Phone Number
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _phoneNumber,
                    decoration: InputDecoration(
                        hintText: "Enter phone number ",
                        border: OutlineInputBorder(),
                        labelText: "PhoneNumber"
                    )),
              ),

            ],),
//Row for the Phone Number
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 350,
                // Adjust the width as needed
                padding: const EdgeInsets.all(10.0),
                // Optional: Add padding
                margin: const EdgeInsets.all(10.0),
                // Optional: Add margin
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Add background color
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius

                ),
                child: TextField(controller: _address,
                    decoration: InputDecoration(
                        hintText: "Enter Your Address",
                        border: OutlineInputBorder(),
                        labelText: "Address:"
                    )),
              ),
            ],),
          //creating the two buttons one is to update(save) and one is to delete
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20,),
              Expanded(flex: 2,
                  child: FilledButton(
                      onPressed: UpdateCustomer, child: Text("Update"))),
              SizedBox(width: 20,),
              Expanded(flex: 2,
                  child: FilledButton(
                      onPressed: DeleteCustomer, child: Text("Delete"))),
            ],
          )


        ],
      ),

    );
  } // else condition ends..
} // widget CustomerDetailsWithForm() ends...

  //function to update the customer
  void UpdateCustomer(){
      if(selectedCustomer != null) {
        //creating an instance of the updated customer.
        Customer updatedCustomer = Customer(
          selectedCustomer!.customer_id, // fetch the selected customer_id from the database.
          //use the updated text value to update the customer entry.
          _firstName.text,
          _lastName.text,
          _email.text,
          _phoneNumber.text,
          _address.text,
          _birthday.text
        );

        //call the dao UpdatedCustomer(Customer) method.
        customerdao.updateCustomer(updatedCustomer).then((value) {
          //gui to react
          setState(() {


          //update the customer to the list.
          int index = customerLists.indexWhere((customer) => customer.customer_id == selectedCustomer!.customer_id);

          if(index != null) {
            customerLists[index] = updatedCustomer;
          }
          selectedCustomer = updatedCustomer;
          });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Customer updated successfully',style: TextStyle(color: Colors.lightGreen),)));
        });
      }
  }

  void DeleteCustomer(){
    setState(() {

      //delete the customer from the database first
      customerdao.deleteCustomer(selectedCustomer!);

      //and then remove from the customer
      customerLists.remove(selectedCustomer);

    });

    //make the selectedCustomer as null, because nothing is selected now, the
    //customer is gone.
    selectedCustomer = null;

  }


} //end of CustomerListPageState class
