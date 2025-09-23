import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // already exists from Step 1


Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;
  final file = File('firestore_seed.json');
  final data = jsonDecode(await file.readAsString());

  // Seed students
  for (var entry in data['students'].entries) {
    await firestore.collection('students').doc(entry.key).set(entry.value);
  }

  // Seed teachers
  for (var entry in data['teachers'].entries) {
    await firestore.collection('teachers').doc(entry.key).set(entry.value);
  }

  print('Firestore seeded successfully!');
}
