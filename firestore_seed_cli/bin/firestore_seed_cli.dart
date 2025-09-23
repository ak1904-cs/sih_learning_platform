// bin/firestore_seed_cli.dart
import 'package:firebase/firebase.dart' as fb;

void main() {
  // Initialize Firebase (replace these with your Firebase project details)
  fb.initializeApp(
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    databaseURL: "YOUR_DATABASE_URL",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID",
    measurementId: "YOUR_MEASUREMENT_ID",
  );

  seedFirestore();
}

void seedFirestore() {
  final firestore = fb.firestore();

  // Seed students
  for (int i = 1; i <= 200; i++) {
    firestore.collection("users").doc("student_$i").set({
      "id": "student_$i",
      "password": "pass$i",
      "role": "student",
      "name": "Student $i",
      "progress": 0
    });
  }

  // Seed teachers
  for (int i = 1; i <= 5; i++) {
    firestore.collection("users").doc("teacher_$i").set({
      "id": "teacher_$i",
      "password": "pass$i",
      "role": "teacher",
      "name": "Teacher $i",
    });
  }

  print("✅ Firestore seeding complete! 200 students + 5 teachers added.");
}
