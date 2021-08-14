class Todo {
  int? id;
  String? description;
  int? valueColor;

  Todo({this.id, this.description, this.valueColor});

  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        id: data['id'],
        description: data['description'],
        valueColor: data['valueColor'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "description": this.description,
        "valueColor": this.valueColor,
      };

  @override
  String toString() {
    return 'Todo{id: $id, description: $description, valueColor: $valueColor}';
  }
}
