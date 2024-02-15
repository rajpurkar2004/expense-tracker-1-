import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/user.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {



  List<String> categoryList = <String>[
    'All',
    'Food',
    'Rent',
    'Groceries',
    'Salary',
    'Business',
    'Health',
    'Beauty',
  ];
  String categoryDropValue = 'All';


  List<String> timeWhen = <String>[
    'All Time',
    'This week',
    'This month',
    'This year',
  ];
  String timeWhenDrop = 'All Time';
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Filter Screen"),),
    body: Column(children: [

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(

          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: "Time",
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.5))),
            value: timeWhenDrop,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                timeWhenDrop = value!;

              });
            },
            items: timeWhen
                .map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),







      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(

          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: "Category",
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(5),
                    borderSide: BorderSide(width: 0.5))),
            value: categoryDropValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                categoryDropValue = value!;

              });
            },
            items: categoryList
                .map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),



      ElevatedButton(onPressed: (){
        if(categoryDropValue=="All" && timeWhenDrop=="All Time"){
          Provider.of<MyUser>(context, listen: false).anyexpense();
          Navigator.pop(context);
        }
        else if(categoryDropValue=="Any" && timeWhenDrop!="All Time"){
          if(timeWhenDrop=="This week")
            {
              Provider.of<MyUser>(context, listen: false).timeIncome("2023-01-04", "2023-12-14");
            }
          
          else if(timeWhenDrop=='This month')
            {
              Provider.of<MyUser>(context, listen: false).timeIncome("2023-01-01", "2023-01-30");
            }
          
          else if(timeWhenDrop=='This year'){
            Provider.of<MyUser>(context, listen: false).timeIncome("2023-01-01", "2023-12-30");
          }
          Navigator.pop(context);
        }

        else if(categoryDropValue!="Any" && timeWhenDrop=="All Time"){
          Provider.of<MyUser>(context, listen: false).categoryIncome(categoryDropValue);
          Navigator.pop(context);
        }

        else{
          Provider.of<MyUser>(context, listen: false).categoryIncome(categoryDropValue);
          Navigator.pop(context);
        }

      }, child: Text("Filter"))
    ],),
    );
  }
}
