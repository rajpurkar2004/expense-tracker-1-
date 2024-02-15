import 'package:expensetrackerapp/screen/bottom_screens/expense_screen.dart';
import 'package:expensetrackerapp/screen/loans_depth_screen.dart';
import 'package:expensetrackerapp/screen/pdf_page.dart';
import 'package:expensetrackerapp/screen/pichart_screen.dart';
import 'package:expensetrackerapp/screen/transaction_screens/only_expense_screen.dart';
import 'package:expensetrackerapp/screen/transaction_screens/only_income_screen.dart';
import 'package:flutter/material.dart';
import '../function/firebase.dart';
import '../model/FirebaseAuth.dart';
import 'bottom_screens/goalscreen.dart';
import 'bottom_screens/loan_screen.dart';
import 'bottom_screens/settings_screen.dart';
import 'goalbudgetshort/budgetscreen.dart';
import 'goalbudgetshort/goalsreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

@override
  void initState() {
  getUser(context);
    super.initState();
  }


  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



  static const List<Widget> _widgetOptions = <Widget>[

    ExpenseScreen(),
    GoalScreen(),
    LoanScreen(),
    SettingsScreen()
  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [

            SizedBox(height: 50,),
            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => OnlyExpense(),)),leading: Icon(Icons.attach_money,color: Colors.green.shade800,),title: Text("Expense"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),
            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>OnlyIncome() ,)),leading: Icon(Icons.money,color: Colors.deepOrangeAccent,),title: Text("Income"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),
            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => GoalsScreenon(),)),leading: Icon(Icons.sports_soccer,color: Colors.green.shade800,),title: Text("Goals"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),
            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>BudgetScreen() ,)),leading: Icon(Icons.account_balance,color: Colors.deepOrangeAccent,),title: Text("Budget"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),

            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>PdfPage() ,)),leading: Icon(Icons.menu_book,color: Colors.green.shade800,),title: Text("Print Out statement"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),

            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>PieChartScreen() ,)),leading: Icon(Icons.pie_chart,color: Colors.deepOrangeAccent,),title: Text("Transaction in Chart"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),

            ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>LoansDepth() ,)),leading: Icon(Icons.menu_book,color: Colors.green.shade800,),title: Text("Print Out Loans and Depth"),trailing: Icon(Icons.keyboard_arrow_right),),
            Divider(),


            ListTile(trailing: Icon(Icons.logout),
            onTap: (){
              signOut();
            },
              subtitle: Text("Signs you out"),
            title: Text("Logout"),
            ),

          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),




      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.sports_baseball_rounded),
            label: 'Goals',
            backgroundColor: Colors.black,
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Loans',
            backgroundColor: Colors.black,
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black,
          ),


        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),




    );
  }
}
