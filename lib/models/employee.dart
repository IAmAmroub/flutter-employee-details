class Employee {
  final int id;
  final String name;
  final int salary;
  final int age;
  final String profileImage;

  const Employee({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
    required this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      name: json['employee_name'] ?? '',
      salary: json['employee_salary'] ?? 0,
      age: json['employee_age'] ?? 0,
      profileImage: json['profile_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age,
      'profile_image': profileImage,
    };
  }
}
