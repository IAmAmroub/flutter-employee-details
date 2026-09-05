import 'package:dio/dio.dart';
import 'package:employee_details_app/models/employee.dart';

class EmployeeService {
  final Dio _dio = Dio();
  static const String _url = 'http://dummy.restapiexample.com/api/v1/employees';

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['status'] == 'success') {
          final List<dynamic> employeesJson = data['data'];

          return employeesJson
              .map(
                (json) => Employee.fromJson(
                  json as Map<String, dynamic>,
                ),
              )
              .toList();
        }

        throw Exception('API returned an unsuccessful status');
      }

      throw Exception(
        'Failed to load employees. Status code: ${response.statusCode}',
      );
    } on DioException catch (error) {
      throw Exception(
        'Network error: ${error.message}',
      );
    } catch (error) {
      throw Exception(
        'Unexpected error: $error',
      );
    }
  }
}
