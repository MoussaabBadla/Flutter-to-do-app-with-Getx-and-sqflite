import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;
  

  Future<int> addtask({required Task task}) async {
    return DBHelper.insert(task);
  }

  getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
  }

  void deletTask({required Task task}) async {
    await DBHelper.delete(task);
    getTask();
  }

  void markasCompleted(int id) async {
    await DBHelper.Update(id);
    getTask();
  }
}
