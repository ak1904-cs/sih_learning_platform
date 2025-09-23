import 'package:firebase_dart/firebase_dart.dart';

Future<void> main() async {
  // Initialize Firebase for CLI
  final app = await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
    ),
  );

  final firestore = FirebaseFirestore(app: app);

  // Seed Students
  for (int i = 1; i <= 200; i++) {
    await firestore.collection('users').doc('student$i').set({
      'id': 'student$i',
      'password': 'pass$i',
      'role': 'student',
    });
  }

  // Seed Teachers
  for (int i = 1; i <= 5; i++) {
    await firestore.collection('users').doc('teacher$i').set({
      'id': 'teacher$i',
      'password': 'teachpass$i',
      'role': 'teacher',
    });
  }

  print("✅ 200 students + 5 teachers added to Firestore!");
}
