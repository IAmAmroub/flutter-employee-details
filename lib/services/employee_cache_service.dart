import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee.dart';

class EmployeeCacheService {
  static const String _employeesKey = 'cached_employees';

  Future<void> saveEmployees(List<Employee> employees) async {
    final preferences = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> employeesJson =
        employees.map((employee) => employee.toJson()).toList();

    final String encodedData = jsonEncode(employeesJson);

    await preferences.setString(_employeesKey, encodedData);
  }

  Future<List<Employee>> loadEmployees() async {
    final preferences = await SharedPreferences.getInstance();

    final String? encodedData = preferences.getString(_employeesKey);

    if (encodedData == null || encodedData.isEmpty) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(encodedData);

    return decodedData
        .map(
          (item) => Employee.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<void> clearEmployees() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_employeesKey);
  }
}
