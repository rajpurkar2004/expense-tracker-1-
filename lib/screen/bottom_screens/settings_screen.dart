

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../auth_screen/userInfo.dart';
import '../expensetrackerin.dart';
import '../notification.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Column(children: [
        ListTile(leading: Icon(Icons.person,color: Colors.greenAccent,), title: Text("User Profile"), subtitle: Text("Change the information abount the user"),
        onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => UsersInfos(),)),
        ),
        Divider(),
        ListTile(leading: Icon(Icons.notifications,color: Colors.lightBlueAccent,), title: Text("Notification"), subtitle: Text("turn on off notification"),
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => NotificationScreen(),)) ,

        ),
        Divider(),
        ListTile(leading: Icon(Icons.info,color: Colors.amberAccent,), title: Text("About Wallet"), subtitle: Text("about wallet"),
        onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => AboutScreen(),)) ,
        ),
        Divider(),
        ListTile(leading: Icon(Icons.logout,color: Colors.deepOrangeAccent,), title: Text("Log out"), subtitle: Text("Logout"),
        onTap: ()=>FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), ModalRoute.withName("/Home")),
        ),

        )],)
      ,);
  }
}
