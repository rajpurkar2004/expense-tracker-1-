import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Notification"),),
     body: Column(children: [
       Center(
         child: SwitchListTile(
           title: Text("Turn off notificaiton"),
           value: isSwitched,
           onChanged: (value) {
             setState(() {
               isSwitched = value;
               print(isSwitched);
             });
           },
           activeTrackColor: Colors.white,
           activeColor: Colors.green.shade800,
         ),
       )
     ],),);
  }
}
