// Model class to represent the API response structure.
class ModelClass {
  List<Todos>? todos; // List of todo items
  int? total; // Total number of todos
  int? skip; // Number of skipped todos (for pagination)
  int? limit; // Number of todos returned per request

  ModelClass({this.todos, this.total, this.skip, this.limit});

  // Converts JSON response into a Dart object.
  ModelClass.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      todos = <Todos>[];
      json['todos'].forEach((v) {
        todos!.add(Todos.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

// Represents a single todo item.
class Todos {
  int? id; // Unique identifier for the todo
  String? todo; // The todo description
  bool? completed; // Status of completion (true/false)
  int? userId; // ID of the user who owns the todo

  Todos({this.id, this.todo, this.completed, this.userId});

  // Converts JSON object into a Dart object.
  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
}
