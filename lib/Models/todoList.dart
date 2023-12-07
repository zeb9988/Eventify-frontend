import 'dart:convert';

class TodoList {
  final String id;
  final String title;
  final String desc;
  final String userId;

  TodoList(
      {required this.id,
      required this.title,
      required this.desc,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {'id': id, 'userId': userId, 'desc': desc, 'title': title};
  }

  factory TodoList.fromMap(Map<String, dynamic> map) {
    return TodoList(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      userId: map['userId'] ?? '',
      desc: map['desc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoList.fromJson(String source) =>
      TodoList.fromMap(json.decode(source));
}
