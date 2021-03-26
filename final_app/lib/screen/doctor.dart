import 'package:flutter/material.dart';

class Doctor extends StatelessWidget {
  List data =[
    {
      "name" : "The First Doctor",
      "pictures" : "assets/doctors/1st_d.png",
    },
    {
      "name" : "The Second Doctor",
      "pictures" : "assets/doctors/2nd_d.png",
    },
    {
      "name" : "The Third Doctor",
      "pictures" : "assets/doctors/3rd_d.png",
    },
    {
      "name" : "The Fourth Doctor",
      "pictures" : "assets/doctors/4th_d.png",
    },
    {
      "name" : "The Fifth Doctor",
      "pictures" : "assets/doctors/5th_d.png",
    },
    {
      "name" : "The Sixth Doctor",
      "pictures" : "assets/doctors/6th_d.png",
    },
    {
      "name" : "The Seventh Doctor",
      "pictures" : "assets/doctors/7th_d.png",
    },
    {
      "name" : "The Eighth Doctor",
      "pictures" : "assets/doctors/8th_d.png",
    },
    {
      "name" : "The War Doctor",
      "pictures" : "assets/doctors/war_d.png",
    },
    {
      "name" : "The Ninth Doctor",
      "pictures" : "assets/doctors/9th_d.png",
    },
    {
      "name" : "The Tenth Doctor",
      "pictures" : "assets/doctors/10th_d.png",
    },
    {
      "name" : "The Eleventh Doctor",
      "pictures" : "assets/doctors/11th_d.png",
    },
    {
      "name" : "The Twelfth Doctor",
      "pictures" : "assets/doctors/12th_d.png",
    },
    {
      "name" : "The Thirteenth Doctor",
      "pictures" : "assets/doctors/13th_d.png",
    },
  ];
  Doctor({this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("The Doctors"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: 2,
            semanticChildCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.0,
            children: data.map((e) {
              return Container(
                width: 200,
                height: 200 ,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(e['pictures']),
                        fit: BoxFit.cover),
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  color: Colors.black45,
                    child: Text(e['name'], style: TextStyle(color: Colors.white),)),
              );
            }).toList(),
          ),
        ),
      );
  }
}
