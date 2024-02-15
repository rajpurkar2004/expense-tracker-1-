import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/FirebaseAuth.dart';
class UpdateExpense extends StatefulWidget {
  const UpdateExpense({Key? key, required this.docid}) : super(key: key);
  final String docid;
  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {


  List<String> list = <String>[
    'Food',
    'Rent',
    'Groceries',
    'Salary',
    'Business',
    'Health',
    'Beauty',
  ];
  String dropdownValue = 'Food';
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  var descriptController = TextEditingController();


  bool income = true;
  bool amount = true;
  String value = "00";



  DateTime selectedDate = DateTime.now();



  void initState() {
    // TODO: implement initState
    final docRef = FirebaseFirestore.instance.collection("main/${FirebaseAuth.instance.currentUser?.uid}/transactions/").doc(widget.docid);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        titleController.text= data["title"];
        amountController.text= data["amount"];
        descriptController.text= data["description"];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const Map<String,IconData> icons = {
      'Food': Icons.fastfood_rounded,
      'Rent': Icons.home_work_outlined,
      'Groceries': Icons.local_grocery_store,
      'Salary':Icons.money,
      'Business': Icons.business,
      'Health': Icons.health_and_safety,
      'Beauty': Icons.clean_hands,
    };



    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            color:Colors.green.shade800,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(child: Text(value, style: TextStyle(fontSize: 45))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: income ? Colors.green.shade800 : Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          amount = true;
                          setState(() {
                            income = true;
                            value = value;
                          });
                        },
                        child: Text("Income")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: income ? Colors.grey : Colors.green.shade800,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          amount = false;
                          setState(() {
                            income = false;
                            value = value;
                          });
                        },
                        child: Text("Expense")),
                  ),
                ],
              ),
            ],),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a transaction title',
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

              controller: amountController,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount ',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a discription',
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






          ElevatedButton(
              onPressed: () {
                income?update(
                  widget.docid,
                    titleController.text.toString(),
                    dropdownValue,
                    descriptController.text.toString(),
                    selectedDate,
                    0,
                    double.parse(amountController.text)):update(
                    widget.docid,
                    titleController.text.toString(),
                    dropdownValue,
                    descriptController.text.toString(),
                    selectedDate,
                    double.parse(amountController.text),
                    0);
                Navigator.pop(context);
              },
              child: Text("Add Transaction"))
        ],
      ),
    );
  }
}
