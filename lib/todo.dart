class Todo {
  String name = "";
  String description = "";
  bool state = false;

  Todo(this.name, this.description, this.state);

  Todo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    description = json["description"];
    state = json["state"];
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "state": state,
    };
  }
}
