import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.ontap}) : super(key: key);
  final String label;
  final Function() ontap; 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(color:Get.isDarkMode? orangeClr: primaryClr,borderRadius: BorderRadius.circular(20)),
        height: 45, 
        width: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
          child: Text(label,style: const TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
        ),
         
      ),
    );
  }
}
