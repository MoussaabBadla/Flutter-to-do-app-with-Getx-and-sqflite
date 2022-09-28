import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/size_config.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    _taskController.getTask();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _taskController.getTask();

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addtaskbar(),
          _datebar(),
          _showtask(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(const AddTaskPage());
        },
        backgroundColor: Get.isDarkMode ? orangeClr : primaryClr,
        child: const Icon(Icons.add),
      ),
    );
  }

  _appbar() {
    return AppBar(
      iconTheme: IconThemeData(color: Get.isDarkMode ? white : darkHeaderClr),
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        onPressed: (() {
          ThemeServices().switchTheme();
        }),
        icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
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
      elevation: 0,
    );
  }

  Widget _addtaskbar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: subhd1,
          ),
          Text(
            'Today',
            style: hd1,
          )
        ],
      ),
    );
  }

  Widget _datebar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedDate,
        width: 80,
        height: 100,
        monthTextStyle: datestyle,
        dateTextStyle: datestyle,
        dayTextStyle: datestyle,
        selectionColor: Get.isDarkMode ? orangeClr : primaryClr,
        deactivatedColor: Get.isDarkMode ? white : darkHeaderClr,
        onDateChange: ((selectedDate) => setState(() {
              _selectedDate = selectedDate;
            })),
      ),
    );
  }

  Future<void> _onrefrech() async {
    _taskController.getTask();
  }

  _showtask() {
    return Expanded(child: Obx(() {
      if (_taskController.taskList.isEmpty) {
        return _nottaskmsg();
      } else {
        return RefreshIndicator(
          onRefresh: () => _onrefrech(),
          child: ListView.builder(
            itemCount: _taskController.taskList.length,
            scrollDirection: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemBuilder: (context, index) {
              _onrefrech();
              if (_taskController.taskList[index].date ==
                      DateFormat.yMd().format(_selectedDate) ||
                  _taskController.taskList[index].repeat == 'Daily') {
                
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          _showbottomsheet(
                              context, _taskController.taskList[index]);
                        },
                        child: TaskTile(
                          task: _taskController.taskList[index],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      }
    }));
  }

  Widget _nottaskmsg() {
    return RefreshIndicator(
      onRefresh: _onrefrech,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape
                    ? const SizedBox(
                        width: 200,
                      )
                    : const SizedBox(
                        height: 200,
                      ),
                SvgPicture.asset(
                  'images/task.svg',
                  color: Get.isDarkMode
                      ? orangeClr.withOpacity(0.5)
                      : primaryClr.withOpacity(0.5),
                  height: 100,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    'You do not  have any task yet! \n Add Tasks to make your life days Productive',
                    style: subtitle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _showbottomsheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.3
                : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkGreyClr : primaryClr,
        child: Column(children: [
          Flexible(
              child: Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          task.isCompleted == 1
              ? Container()
              : _buildbottumsheet(
                  label: 'TaskCompleted',
                  ontap: () {
                    _taskController.markasCompleted(task.id!);
                    Get.back();
                  },
                  clr: Get.isDarkMode ? orangeClr : primaryClr),
          Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
          _buildbottumsheet(
              label: 'Delet Task',
              ontap: () {
                _taskController.deletTask(task: task);

                Get.back();
              },
              clr: Get.isDarkMode ? orangeClr : primaryClr),
          Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
          _buildbottumsheet(
              label: 'Cancel',
              ontap: () {
                Get.back();
              },
              clr: Get.isDarkMode ? orangeClr : primaryClr),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    ));
  }

  _buildbottumsheet({
    required String label,
    required Function() ontap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 64,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titlestyle : titlestyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
