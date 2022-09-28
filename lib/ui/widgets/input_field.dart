import 'package:flutter/material.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.mywid})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? mywid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(title, style: titlestyle),
        ),
        Container(
            width: SizeConfig.screenWidth,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: subtitle,
                    readOnly: mywid == null ? false : true,
                    controller: controller,
                    autocorrect: false,
                    autofocus: false,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: hint,
                      hintStyle: subtitle,
                    ),
                  ),
                ),
                mywid ?? Container(),
              ],
            )),
      ],
    );
  }
}
