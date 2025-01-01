# Appointment booking app

**IMPORTANT!!!!**

Please refer to the README.md file in the backend_service package within this codebase for instructions on starting the server required for successful API requests.

## Run app

To successfully run this application, follow these steps:

1. **Install Dependencies**  
    Run the following command to install all dependencies:

    ``` flutter pub get ```

2. **Code Generation**  
    Generate any necessary files by running the code generation process:

    ``` flutter pub run build_runner build --delete-conflicting-outputs ```

## Run Tests

To generate a test coverage report, execute the following script:

```bash
./scripts/generate_html_coverage_report.sh
```

## Dependencies

| **Name**                | **Description**                                  |
|--------------------------|--------------------------------------------------|
| **auto_route**           | Route generation and navigation management      |
| **flutter_hooks**        | React-style lifecycle hooks for Flutter         |
| **hooks_riverpod**       | Advanced state management with hooks            |
| **riverpod**             | State management solution for dependency injection |
| **injectable**           | Code generation for dependency injection        |
| **flutter_styled_toast** | Customizable toast notifications                |
| **dio**                  | HTTP client for network requests                |
| **get_it**               | Simple service locator for dependency injection |
| **freezed_annotation**   | Annotation for data classes and sealed unions   |
| **json_annotation**      | Annotation for JSON serialization and deserialization |
| **logger**               | Logging utility for structured logs             |
| **intl**                 | Internationalization and localization support   |

### **Dev Dependencies**

| **Name**                | **Description**                                  |
|--------------------------|--------------------------------------------------|
| **build_runner**         | Code generation utility for Dart projects       |
| **auto_route_generator** | Generates route navigation code using `auto_route` |
| **freezed**              | Code generator for `freezed_annotation`         |
| **injectable_generator** | Generates dependency injection code for `injectable` |
| **json_serializable**    | Generates code for JSON serialization and deserialization |
| **mockito**              | Mocking library for writing unit tests          |
