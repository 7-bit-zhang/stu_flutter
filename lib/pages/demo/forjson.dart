class DataClass {
  late String name;
  late String age;
  DataClass({required this.name, required this.age});

  factory DataClass.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'age': String age} =>
        DataClass(name: name, age: age),
      _ => throw const FormatException("Json is not valid")
    };
  }
}
