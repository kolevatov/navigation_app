class Student {
  int? id;
  late String name;

  Student(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {'ID': id, 'NAME': name};
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    name = map['NAME'];
  }
}
