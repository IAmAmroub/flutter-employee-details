import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final Employee employee;
  const EmployeeDetailsPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    child: Text(
                      employee.id.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Name: ${employee.name}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  'Age: ${employee.age}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  'Salary: ${employee.salary}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
