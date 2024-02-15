import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../function/data.dart';
import 'corsel_card.dart';

class CorselSlider extends StatefulWidget {
  const CorselSlider({Key? key, required this.income, required this.expense, required this.remaining}) : super(key: key);
final double income;
final double expense;
final double remaining;

  @override
  State<CorselSlider> createState() => _CorselSliderState();
}

class _CorselSliderState extends State<CorselSlider> {


  int currentPos = 0;


  List<String> listTitle = [
    "Current Balance",
    "Total income",
    "Total Spend",

  ];


  @override
  Widget build(BuildContext context) {

    List<double>toatals=[
      widget.remaining,
      widget.income,
      widget.expense,

    ];
    return Column(children: [

      CarouselSlider.builder(
        itemCount: listTitle.length,
        options: CarouselOptions(
            height: 150,

            onPageChanged: (index, reason) {
              print(currentPos);
              setState(() {
                currentPos = index;
              });
            }
        ),
        itemBuilder: (context,itemIndex,pageViewIndex) =>CorselCard(amount: toatals[itemIndex], title: listTitle[itemIndex],),

      ),


      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: toatals.map((url) {
          int index = toatals.indexOf(url);
          print(index);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPos == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),


    ],);
  }
}
