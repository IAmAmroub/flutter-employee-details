import 'package:employee_details_app/models/employee.dart';
import 'package:employee_details_app/services/employee_cache_service.dart';
import 'package:employee_details_app/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'employee_details_page.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final EmployeeService _employeeService = EmployeeService();
  final EmployeeCacheService _employeeCacheService = EmployeeCacheService();

  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final cachedEmployees = await _employeeCacheService.loadEmployees();

    if (!mounted) return;

    setState(() {
      _employees = cachedEmployees;
    });

    await _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final employees = await _employeeService.fetchEmployees();

      await _employeeCacheService.saveEmployees(employees);

      if (!mounted) return;

      setState(() {
        _employees = employees;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = _employees.isEmpty
            ? 'Failed to load employees.'
            : 'Could not refresh. Showing cached data.';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees List"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: RefreshIndicator(
              onRefresh: _fetchEmployees,
              child: Column(
                children: [
                  if (_isLoading) const LinearProgressIndicator(),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Expanded(
                    child: _employees.isEmpty && !_isLoading
                        ? const Center(
                            child: Text('No employees available.'),
                          )
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _employees.length,
                            itemBuilder: (context, index) {
                              final employee = _employees[index];

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(employee.id.toString()),
                                  ),
                                  title: Text(employee.name),
                                  subtitle: Text(
                                    'Age: ${employee.age}\n'
                                    'Salary: ${employee.salary}',
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EmployeeDetailsPage(
                                          employee: employee,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
