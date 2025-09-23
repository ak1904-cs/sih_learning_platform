import 'dart:convert';
import 'dart:io';

void main() {
  final Map<String, dynamic> data = {
    "students": {},
    "teachers": {}
  };

  // Generate 500 students
  for (int i = 1; i <= 500; i++) {
    final id = "S${i.toString().padLeft(3, '0')}";
    data["students"]![id] = {
      "id": id,
      "password": "pass123",
      "role": "student",
      "progress": {}
    };
  }

  // Generate 10 teachers
  for (int i = 1; i <= 10; i++) {
    final id = "T${i.toString().padLeft(3, '0')}";
    data["teachers"]![id] = {
      "id": id,
      "password": "teach123",
      "role": "teacher",
      "uploadedContent": []
    };
  }

  final file = File("firestore_seed.json");
  file.writeAsStringSync(JsonEncoder.withIndent("  ").convert(data));

  print("firestore_seed.json generated successfully!");
}
