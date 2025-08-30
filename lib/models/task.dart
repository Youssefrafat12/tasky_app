class Task {
  final String name;
  final String description;
  final bool highPriority;
  final bool isDone;

  Task({
    required this.name,
    required this.description,
    this.highPriority = false,
    this.isDone = false,
  });

  Task copyWith({
    String? name,
    String? description,
    bool? highPriority,
    bool? isDone,
  }) {
    return Task(
      name: name ?? this.name,
      description: description ?? this.description,
      highPriority: highPriority ?? this.highPriority,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'highPriority': highPriority,
    'isDone': isDone,
  };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
      highPriority: json['highPriority'] ?? false,
      isDone: json['isDone'] ?? false,
    );
  }
}
