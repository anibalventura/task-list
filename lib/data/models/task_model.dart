class Task {
  Task({
    required this.id,
    required this.name,
    required this.isComplete,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isComplete = json['isComplete'];

  int id;
  String name;
  bool isComplete;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isComplete': isComplete,
      };
}
