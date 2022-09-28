import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';

import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selecteddate = DateTime.now();
  String _staretime = DateFormat('hh:mm').format(DateTime.now()).toString();
  String _endetime = DateFormat('hh:mm')
      .format(DateTime.now().add(const Duration(minutes: 15)));
  int _selectedRemind = 2;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatlist = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selecterColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbare(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Task',
                style: hd1,
              ),
              InputField(
                title: 'Add Task',
                hint: 'Enter task title here ',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter  Note here ',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selecteddate),
                mywid: IconButton(
                  onPressed: () {
                    _getdatefromuser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'StartTime',
                      hint: _staretime,
                      mywid: IconButton(
                        onPressed: () {
                          _gettime(isStarttime: true);
                          print(_staretime);
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      title: 'EndTime',
                      hint: _endetime,
                      mywid: IconButton(
                        onPressed: () {
                          _gettime(isStarttime: false);
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                mywid: DropdownButton(
                    underline: Container(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    elevation: 4,
                    iconSize: 32,
                    items: remindList
                        .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  '$value minutes',
                                  style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                )))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRemind = int.parse(value!);
                      });
                    }),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                mywid: DropdownButton(
                    underline: Container(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    elevation: 4,
                    iconSize: 32,
                    items: repeatlist
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                )))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRepeat = value!;
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorspallet(),
                    MyButton(
                        label: 'CreatTask',
                        ontap: () {
                          _validate();
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validate() async{
    if (_titleController.text.isNotEmpty &&
        _noteController.text.isNotEmpty )  {
    await  _addtaskstodb();
      Get.back();
    } else {
      if (_titleController.text.isEmpty ||
          _noteController.text.isEmpty ) {
        Get.snackbar(
          'Required',
          'All field are required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: orangeClr,
          colorText: Colors.white,
          icon: const Icon(
            Icons.warning_rounded,
            color: Colors.black,
          ),
        );
      } else {
        print('Somthing bad HAPPENEEEEEEEEEED');
      }
    }
  }

  _addtaskstodb() async {
    print(_staretime);
    int val = await _taskController.addtask(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selecteddate),
            startTime: _staretime,
            endTime: _endetime,
            color: _selecterColor,
            remind: _selectedRemind,
            repeat: _selectedRepeat));
    print(val);
        print(_staretime);

  }

  AppBar _appbare() {
    return AppBar(
      iconTheme: IconThemeData(color: Get.isDarkMode ? white : darkHeaderClr),
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: (() => Get.back()),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Column _colorspallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Colors',
          style: titlestyle,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selecterColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                  child: _selecterColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _getdatefromuser() async {
    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: _selecteddate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (pickeddate != null) setState(() => _selecteddate = pickeddate);
  }

  _gettime({required bool isStarttime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStarttime
          ? DateTime.now()
          : DateTime.now().add(const Duration(minutes: 15))),
    );
    print(pickedTime == null);
    if (pickedTime != null) {
      String formattime = pickedTime.format(context);
      print(formattime);
      if (isStarttime) {
        setState(() => _staretime = formattime);
      } else if (!isStarttime) {
        setState(() => _endetime = formattime);
      }
    } else {
      print('Errooooooooor');
    }
  }
}
