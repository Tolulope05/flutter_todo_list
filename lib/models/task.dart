class Task {
  int? id;
  String title;
  String note;
  int? isCompleted;
  String date;
  String startTime;
  String endTime;
  // Color color;
  int color;
  int remind;
  String repeat;

  Task({
    this.id,
    required this.title,
    required this.note,
    this.isCompleted = 0,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      color: json['color'],
      // color: Color(json['color']),
      remind: json['remind'],
      repeat: json['repeat'],
    );
  }

  // To Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data["note"] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    // data['color']= this.color.value;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}
