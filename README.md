# Flutter Employee Details App

A Flutter application that fetches employee data from a REST API using Dio, caches the data locally using shared_preferences, supports offline access, and displays employee details on a separate screen.

## Features

- Fetch employee data from a REST API
- Use Dio for HTTP requests
- Parse JSON into Dart model objects
- Display employees in a scrollable list
- Show loading indicators
- Handle network and API errors
- Retry failed requests
- Pull-to-refresh support
- Cache employees using shared_preferences
- Load cached employees on app startup
- Support offline employee browsing
- Navigate to an employee details screen
- Display employee name, age, and salary
- Clean separation between model, service, cache, and UI layers

## API Endpoint

```text
http://dummy.restapiexample.com/api/v1/employees
```

The API returns employee data such as:

```json
{
  "id": 1,
  "employee_name": "Tiger Nixon",
  "employee_salary": 320800,
  "employee_age": 61,
  "profile_image": ""
}
```

## Project Structure

```text
lib/
├── docs/
│   └── flutter_00.png
│   └── flutter_01.png
│   └── flutter_02.png
│   └── flutter_03.png
├── main.dart
├── models/
│   └── employee.dart
├── screens/
│   ├── employee_list_page.dart
│   └── employee_details_page.dart
└── services/
    ├── employee_service.dart
    └── employee_cache_service.dart
```

## Employee Model

The `Employee` model contains:

```text
id
name
salary
age
profileImage
```

The model provides:

- `Employee.fromJson()` for converting API JSON into Dart objects
- `toJson()` for converting employee objects back into JSON-compatible data

## API Service

The project uses Dio to perform the HTTP GET request.

```dart
final response = await _dio.get(_url);
```

The API logic is separated into:

```text
lib/services/employee_service.dart
```

The service handles:

- HTTP requests
- response status validation
- API status validation
- JSON conversion
- Dio exceptions
- unexpected errors

## Local Cache

Employee data is cached locally using the `shared_preferences` package.

The cache service is located in:

```text
lib/services/employee_cache_service.dart
```

The employee list is converted to JSON and stored as a string.

```text
List<Employee>
      ↓
toJson()
      ↓
jsonEncode()
      ↓
SharedPreferences
```

When the application starts:

```text
SharedPreferences
      ↓
jsonDecode()
      ↓
Employee.fromJson()
      ↓
List<Employee>
```

## Offline Support

The application first loads previously cached employee data.

It then attempts to fetch fresh data from the API.

```text
App Start
   ↓
Load Cached Employees
   ↓
Display Cached Data
   ↓
Fetch Fresh API Data
   ↓
Save Updated Data
```

If the API request fails but cached data exists, the application continues displaying the cached employees.

## Employee List Screen

The employee list screen includes:

- employee ID
- employee name
- employee age
- employee salary
- loading indicator
- error message
- pull-to-refresh
- refresh action
- navigation to employee details

## Employee Details Screen

When an employee is selected, the application opens a separate details screen.

The details screen displays:

- Employee ID
- Name
- Age
- Salary

## Dependencies

The project uses:

```yaml
dio:
shared_preferences:
```

Install the required packages with:

```bash
flutter pub add dio
flutter pub add shared_preferences
```

## Android HTTP Configuration

The exercise API uses plain HTTP instead of HTTPS.

For Android, cleartext traffic may need to be enabled in:

```text
android/app/src/main/AndroidManifest.xml
```

Inside the `<application>` element:

```xml
android:usesCleartextTraffic="true"
```

Internet permission should also be available:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Getting Started

Clone the repository:

```bash
git clone <repository-url>
```

Enter the project directory:

```bash
cd employee_details_app
```

Install dependencies:

```bash
flutter pub get
```

Check available devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

Or run on a specific device:

```bash
flutter run -d <device-id>
```

## Code Quality

Format the Dart code:

```bash
dart format lib
```

Analyze the Flutter project:

```bash
flutter analyze
```

## Git Workflow

This project uses a GitFlow-style workflow:

```text
feature/* → develop → main
```

- `main` contains the stable version
- `develop` contains integrated development work
- `feature/*` branches are used for individual features

Example feature branches:

```text
feature/dio-api
```

## Technologies

- Flutter
- Dart
- Dio
- shared_preferences
- REST API
- JSON
- Git
- GitHub

## Author

Created as part of a Flutter data-handling exercise.
