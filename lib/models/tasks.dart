class TaskData {
  String id;
  String title;
  String description;
  int date;
  bool isDone;

  TaskData({this.id = "",
    required this.title,
    required this.date,
    required this.description,
    this.isDone = false});


  Map<String, dynamic> toJson() {

    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone
    };
  }
  TaskData.fromJson(Map<String, dynamic>Json) :
        this(
          id: Json["id"],
          title: Json["title"],
          description: Json["description"],
          date: Json["date"],
          isDone: Json["isDone"]
      );
 }
