import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const LoginScreen({super.key, required this.onLocaleChange});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  String language = 'pa';
  bool isTeacher = false; // Toggle for teacher login

  String getLabel(String en, String hi, String pa) {
    if (language == 'en') return en;
    if (language == 'hi') return hi;
    return pa;
  }

  Future<void> login() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = json.decode(response);

      if (isTeacher) {
        final List teachers = data["teachers"];
        final teacher = teachers.firstWhere(
          (t) =>
              t["id"].toString() == userController.text.trim() &&
              t["password"] == passController.text.trim(),
          orElse: () => null,
        );

        if (teacher != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherDashboard(teacherId: teacher['id']),
            ),
          );
          return;
        }
      } else {
        final List students = data["students"];
        final student = students.firstWhere(
          (s) =>
              s["id"].toString() == userController.text.trim() &&
              s["password"] == passController.text.trim(),
          orElse: () => null,
        );

        if (student != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudentDashboard(
                onLocaleChange: widget.onLocaleChange,
                student: student,
              ),
            ),
          );
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(getLabel(
              "Invalid ID/Password", "गलत आईडी/पासवर्ड", "ਗਲਤ ਆਈ.ਡੀ./ਪਾਸਵਰਡ")),
        ),
      );
    } catch (e) {
      print("Error loading data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(getLabel(
              "Error loading data", "डेटा लोड करने में त्रुटि", "ਡਾਟਾ ਲੋਡ ਕਰਨ ਵਿੱਚ ਗਲਤੀ")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getLabel('Login', 'लॉगिन', 'ਲੌਗਿਨ'),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      labelText:
                          getLabel('User ID', 'यूज़र आईडी', 'ਯੂਜ਼ਰ ਆਈ.ਡੀ.'),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText:
                          getLabel('Password', 'पासवर्ड', 'ਪਾਸਵਰਡ'),
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(getLabel(
                        'Login as Teacher',
                        'शिक्षक के रूप में लॉगिन',
                        'ਅਧਿਆਪਕ ਵਜੋਂ ਲੌਗਿਨ')),
                    value: isTeacher,
                    onChanged: (val) {
                      setState(() {
                        isTeacher = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: login,
                      child: Text(
                        getLabel('Login', 'लॉगिन', 'ਲੌਗਿਨ'),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        language = value.toLowerCase();
                      });
                      if (value == 'EN') widget.onLocaleChange(const Locale('en'));
                      if (value == 'HI') widget.onLocaleChange(const Locale('hi'));
                      if (value == 'PA') widget.onLocaleChange(const Locale('pa'));
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'EN', child: Text('English')),
                      PopupMenuItem(value: 'HI', child: Text('हिन्दी')),
                      PopupMenuItem(value: 'PA', child: Text('ਪੰਜਾਬੀ')),
                    ],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language),
                        const SizedBox(width: 8),
                        Text(language.toUpperCase()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
