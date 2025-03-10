#!/usr/bin/env bash

# Run flutter test with coverage
flutter test --coverage

# Path to the coverage info file generated by flutter test
coverage_info="coverage/lcov.info"

file=test/coverage.g.dart
echo "// Helper file to make coverage work for all dart files" > $file
echo "// ignore_for_file: unused_import, import_of_non_library" >> $file

# Find all Dart files in the lib directory recursively, excluding certain files or directories
find lib  -not -name 'generated*/*' \
          -not -name '*.g.dart' \
          -and -not -name '*.freezed.dart' \
          -and -not -path '*/domain/*' \
          -and -not -path '*/infrastructure/api/*' \
          -and -not -path '*/presentation/router/*' \
          -and -not -path '*/presentation/widgets/*' \
          -and -not -name '*theme.dart' \
          -and -not -name '*main.dart' \
          -and -not -name '*appointment_booking_app.dart' \
          -and -not -name '*providers.dart' \
          -and -not -name '*_state.dart' \
          -and -name '*.dart' | while read -r dart_file; do
  # Get the relative path of the Dart file
  relative_path=${dart_file#lib/}
  # Generate import statement for the Dart file
  echo "import 'package:appointment_booking_challenge/$relative_path';" >> $file
done

# Add a main function to satisfy code coverage tools
echo -e "\nvoid main() {}\n" >> $file

# Remove unnecessary files or directories from the lcov report
lcov --remove $coverage_info \
  '*/appointment_booking_app.dart' \
  '*/domain/*' \
  '*/infrastructure/api/*' \
  '*/presentation/router/*' \
  '*/presentation/widgets/*' \
  '*/infrastructure/custom_printer.dart' \
  '*/infrastructure/providers.dart' \
  '*/theme.dart' \
  -o coverage/new_lcov.info

# Generate HTML coverage report
genhtml coverage/new_lcov.info -o coverage

# Open HTML coverage report in web browser
open coverage/index.html  # Use appropriate command for your OS
