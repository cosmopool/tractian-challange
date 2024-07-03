class Company {
  Company({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  static fromJson(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      name: map['name'],
    );
  }
}
