import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TeacherCoursePage extends StatefulWidget {
  final String courseId;
  final String teacherId;
  const TeacherCoursePage({super.key, required this.courseId, required this.teacherId});

  @override
  State<TeacherCoursePage> createState() => _TeacherCoursePageState();
}

class _TeacherCoursePageState extends State<TeacherCoursePage> {
  List lessons = [];

  @override
  void initState() {
    super.initState();
    loadLessons();
  }

  Future<void> loadLessons() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = json.decode(response);

      setState(() {
        lessons = data['lessons']
            .where((lesson) =>
                lesson['courseId'] == widget.courseId &&
                lesson['teacherId'] == widget.teacherId)
            .toList();
      });
    } catch (e) {
      print("Error loading lessons: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Course Lessons"),
        backgroundColor: Colors.blueAccent,
      ),
      body: lessons.isEmpty
          ? const Center(
              child: Text(
                "No lessons added yet",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      lesson['title'] ?? 'No Title',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        lesson['description'] ?? '',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.blueAccent),
                    onTap: () {
                      // Optionally, handle lesson tap
                    },
                  ),
                );
              },
            ),
    );
  }
}
