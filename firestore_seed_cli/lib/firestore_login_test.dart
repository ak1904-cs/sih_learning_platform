import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreLoginTest extends StatefulWidget {
  const FirestoreLoginTest({super.key});

  @override
  State<FirestoreLoginTest> createState() => _FirestoreLoginTestState();
}

class _FirestoreLoginTestState extends State<FirestoreLoginTest> {
  final _idController = TextEditingController();
  final _passController = TextEditingController();
  String _message = '';

  Future<void> _testLogin() async {
    final id = _idController.text.trim();
    final pass = _passController.text.trim();

    final doc = await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (!doc.exists) {
      setState(() => _message = 'User ID not found.');
      return;
    }

    final data = doc.data();
    if (data?['password'] != pass) {
      setState(() => _message = 'Incorrect password.');
      return;
    }

    setState(() => _message = 'Login successful! Role: ${data?['role']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore Login Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _testLogin, child: const Text('Test Login')),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
