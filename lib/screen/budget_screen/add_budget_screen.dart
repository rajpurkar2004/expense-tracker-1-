import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/model/FirebaseAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({Key? key}) : super(key: key);

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {

  List<String> list = <String>[
    'Car',
    'Apartment',
    'Mobile',
    'Pc Build',
    'Land',
    'Marriage',
    'Tuition fee',
  ];
  String dropdownValue = 'Car';




  var nameController=TextEditingController();
  var amountController=TextEditingController();
  var saveController=TextEditingController();

  DateTime goalDate = DateTime.now();
  @override
  Widget build(BuildContext context) {


    const Map<String,IconData> icons = {
      'Car': Icons.car_rental,
      'Apartment': Icons.apartment,
      'Mobile': Icons.install_mobile,
      'Pc Build':Icons.laptop,
      'Land': Icons.landscape,
      'Marriage': Icons.handshake,
      'Tuition fee': Icons.account_balance_outlined,
    };


    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: goalDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != goalDate) {
        setState(() {
          goalDate = picked;
        });
      }
    }

    return Scaffold(appBar: AppBar(title: Text("New Budget"),),body:

    ListView(children: [

      Container(height: 200,
        color: Colors.greenAccent,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Budget Name',
          ),
        ),
      ),


      Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: "Category",
                enabledBorder: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.5))),
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(icons[value]),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),


                    ],)
              );
            }).toList(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: amountController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'total Spending limit',
          ),
        ),
      ),


      ElevatedButton(
          onPressed: () {
            _selectDate(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(Icons.date_range,color: Colors.deepPurpleAccent,),
              Text("Pick a date")
            ],)),

      ElevatedButton(onPressed: (){



        final goal = <String, dynamic>{
          "name": nameController.text.toString(),
          "budget": double.parse(amountController.text.toString()),
          "time":  Timestamp.fromDate(goalDate)
        };

        docref.collection("budget")
            .doc()
            .set(goal)
            .onError((e, _) => print("Error writing document: $e"));


        Navigator.pop(context);

      }, child: Text("Save"))

    ],
    ),);
  }
}
