// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.paylaod}) : super(key: key);
  final String paylaod;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paylaod = '';
  @override
  void initState() {
    super.initState();
    _paylaod = widget.paylaod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              iconTheme: IconThemeData(color: Get.isDarkMode?white:darkHeaderClr),
            backgroundColor: context.theme.backgroundColor,

        actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,

        ),
                SizedBox(width: 10,),

      ],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: (() => Get.back()),
        ),
        title: Text(
          _paylaod.toString().split('|')[0],
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                'Hello,Moussab',
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('You have a new reminder ', style: TextStyle(fontSize: 18))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: primaryClr),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                
                children: [
                Row(
                  children: const [
                    Icon(
                      Icons.text_format,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Title',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _paylaod.toString().split('|')[0],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _paylaod.toString().split('|')[1],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Date',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _paylaod.toString().split('|')[2],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ))
        ],
      )),
    );
  }
}
