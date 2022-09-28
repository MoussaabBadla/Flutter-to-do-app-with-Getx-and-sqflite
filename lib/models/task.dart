// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
     id :  map['id'] != null ? map['id'] as int : null,
      title :  map['title'] != null ? map['title'] as String : null,
     note :  map['note'] != null ? map['note'] as String : null,
    isCompleted:  map['isCompleted'] != null ? map['isCompleted'] as int : null,
    date:   map['date'] != null ? map['date'] as String : null,
    startTime :  map['startTime'] != null ? map['startTime'] as String : null,
    endTime :  map['endTime'] != null ? map['endTime'] as String : null,
    color:  map['color'] != null ? map['color'] as int : null,
    remind :  map['remind'] != null ? map['remind'] as int : null,
    repeat :   map['repeat'] != null ? map['repeat'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
