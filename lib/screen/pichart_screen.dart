import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/screen/transaction_screens/updateExpense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../data/user.dart';
import '../widget/expense_card.dart';
class PieChartScreen extends StatefulWidget {
  const PieChartScreen({Key? key}) : super(key: key);

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  Map<String, double> dataMap = {
    'Food':0,
    'Rent':0,
    'Groceries':0,
    'Business':0,
    'Health':0,
    'Salary':0,
    'Beauty':0,

  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Pie Chart"),),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [


        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("main").doc(FirebaseAuth.instance.currentUser!.uid).collection("transactions")
                .snapshots(),
            builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              var ds =  snapshot.data!.docs;
              for(int i=0; i<ds.length;i++)
              {
                dataMap.update(ds[i]['category'], (value) => value+1);
              }
              
              return dataMap.isEmpty?Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text("Pie Chart not avaialbe"),
              ):
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 50,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: clorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 50,
                    centerText: "Pie chart",
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                );

            }),




        Flexible(
          child: Container(

            child: StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').snapshots(),

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                    return  GestureDetector(
                        onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateExpense(docid:document.id),)) ,

                        child: ExpenseCard(title: data["title"],subtitle: data["description"],amount:data["income"].toString(),date: data["datetime"],icondata: data["category"],));
                  }).toList(),
                );

              },
            ),
          ),
        ),


    ],),
    );
  }
}
