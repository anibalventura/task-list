class Task {
  Task({
    required this.id,
    required this.name,
    required this.isComplete,
  });

  Task.fromJson(Map<String, dynamic> json) 
      : id = json['id'] as int,
        name = json['name'] as String,
        isComplete = json['isComplete'] as bool;

  int id;
  String name;
  bool isComplete;

  Map<String, dynamic> toJson() => <String, dynamic> {
        'id': id,
        'name': name,
        'isComplete': isComplete,
      };
}
